xml.instruct!
xml.Response do
  xml.Gather(timeout: 15) do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      We're sorry, you have entered an invalid extension.
      Please re-enter the extension of the psychic you wish to contact and
      press pound.
    EOS
  end
end
