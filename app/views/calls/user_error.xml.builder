xml.instruct!
xml.Response do
  xml.Gather do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      I'm sorry, the phone number you entered is invalid.
      Please enter your 10 digit phone number and press the pound key.
    EOS
  end
end
