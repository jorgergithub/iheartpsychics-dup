xml.instruct!
xml.Response do
  if @client
    xml.Gather(action: calls_url_for("pin", phone_number)) do
      xml.Say <<-EOS.strip_heredoc, voice: "woman"
        Welcome back to I Heart Psychic #{@client.first_name}.
        Please enter your PIN number to validate your account
        and press pound.
      EOS
    end
  else
    xml.Gather(action: calls_url_for("user", phone_number)) do
      xml.Say <<-EOS.strip_heredoc, voice: "woman"
        Welcome to I Heart Psychics.
        We don't recognize the number you are calling from.
        Please enter your ten digit account or
        press zero to be connected with a customer service representative.
      EOS
    end
  end
end
