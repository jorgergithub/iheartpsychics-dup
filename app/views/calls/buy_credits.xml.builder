xml.instruct!
xml.Response do
  xml.Gather(action: calls_url_for("confirm_credits?package_id=#{@package.id}", phone_number), numDigits: 1, timeout: 15) do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      You have chosen to add #{price_to_phrase @package.credits} to your account
      for #{price_to_phrase(@package.price)}.
      Press 1 to confirm or press 2 to return to the previous menu.
    EOS
  end
end
