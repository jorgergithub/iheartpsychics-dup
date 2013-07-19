xml.instruct!
xml.Response do
  xml.Gather do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      I'm sorry, the extension you entered is invalid.
      Please enter the four digit extension of your psychic followed by the pound sign.
    EOS
  end
end
