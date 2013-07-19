xml.instruct!
xml.Response do
  xml.Gather do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      I'm sorry, the PIN number you entered is invalid.
      Please enter your four digit PIN number and press the pound key.
    EOS
  end
end
