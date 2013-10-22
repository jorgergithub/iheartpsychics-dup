xml.instruct!
xml.Response do
  xml.Gather do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      We're sorry, you have selected an unavailable psychic.
      Please re-enter the extension of the psychic you wish to contact and
      press pound.
    EOS
  end
end
