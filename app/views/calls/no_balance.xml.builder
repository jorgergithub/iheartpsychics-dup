xml.instruct!
xml.Response do
  xml.Say <<-EOS.strip_heredoc, voice: "woman"
    Your account is out of minutes. Please visit I heart psychics dot com
    to add more minutes and call us back.
    Thank you.
  EOS
end
