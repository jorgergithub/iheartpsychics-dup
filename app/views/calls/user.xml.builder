xml.instruct!
xml.Response do
  xml.Gather(action: calls_url_for("pin", @phone_number)) do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      Welcome back #{@client.first_name}.
      Please enter your four digit PIN number and press the pound key.
    EOS
  end
end
