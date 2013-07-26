xml.instruct!
xml.Response do
  xml.Gather(action: calls_url_for("topup", phone_number), numDigits: 1) do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      Thank you for validating your account #{@client.first_name}.
      Your account is out of minutes.
    EOS
    if @client.cards.try(:any?)
      xml.Say <<-EOS.strip_heredoc, voice: "woman"
        Please press 1 to purchase more minutes.
      EOS
    end
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      Press 2 to speak to a customer service representative.
      Press 3 to disconnect.
    EOS
  end
end
