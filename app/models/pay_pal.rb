class PayPal
  def initialize(view_context, reference, description, amount, tax=0)
    @view_context = view_context
    @reference = reference
    @description = description
    @amount = amount
    @tax = tax
  end

  def form(*args)
    @view_context.form_tag ENV["PAYPAL_URL"], id: "paypal_form" do
      @view_context.hidden_field_tag :cmd, "_s-xclick"
      @view_context.hidden_field_tag :encrypted, encrypted
      yield if block_given?
    end
    "<form id=\"paypal_form\"

    <<-EOS.strip_heredoc!
    <form accept-charset="UTF-8" action="https://www.sandbox.paypal.com/cgi-bin/webscr" id="paypal_form" method="post">

    </form>
    EOS
  end

  def encrypted
    signed = OpenSSL::PKCS7::sign(
      OpenSSL::X509::Certificate.new(
        File.read(ENV["PAYPAL_APP_CERT"])),
      OpenSSL::PKey::RSA.new(
        File.read(ENV["PAYPAL_APP_KEY"]), ''),
      values.map { |k, v| "#{k}=#{v}" }.join("\n"),
      [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt(
      [OpenSSL::X509::Certificate.new(
        File.read(ENV["PAYPAL_APP_CERT"]))],
      signed.to_der,
      OpenSSL::Cipher::Cipher::new("DES3"),
      OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
  end

  def values
    @values ||=
      {
        business: ENV["PAYPAL_ACCOUNT"],
        cmd: "_xclick",
        item_name: @description,
        amount: @amount,
        tax: @tax,
        no_note: 1,
        no_shipping: 1,
        currency_code: "USD",
        custom: @reference,
        return: ENV["PAYPAL_SUCCESS_URL"],
        cancel_return: ENV["PAYPAL_CANCEL_URL"],
        notify_url: ENV["PAYPAL_NOTIFY_URL"],
        bn: "IHP_ST",
        rm: "2",
        invoice: @reference,
        cert_id: ENV["PAYPAL_APP_CERT_ID"]
      }
  end
end
