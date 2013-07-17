xml.instruct!
xml.Response do
  xml.Gather(action: calls_url_for("pin", @phone_number)) do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      Welcome back #{@client.first_name}.
      Please enter your five digit PIN number and press the pound key.
    EOS
  end
end
