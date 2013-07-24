xml.instruct!
xml.Response do
  xml.Gather do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      We're sorry, the number you have provided is not
      in our system.
      Please re-enter your 10 digit account number and press pound.
    EOS
  end
end
