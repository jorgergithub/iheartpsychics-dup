xml.instruct!
xml.Response do
  if @client
    xml.Gather(action: calls_url_for("pin", phone_number)) do
      xml.Say <<-EOS.strip_heredoc, voice: "woman"
        Welcome back #{@client.first_name}.
        Please enter your four digit PIN number and press the pound key.
      EOS
    end
  else
    xml.Gather(action: calls_url_for("user", phone_number)) do
      xml.Say <<-EOS.strip_heredoc, voice: "woman"
        Welcome to I Heart Psychics.
        Please enter your ten digits phone number press the pound key.
        If you don't have an account, please press zero and the pound key.
      EOS
    end
  end
end
