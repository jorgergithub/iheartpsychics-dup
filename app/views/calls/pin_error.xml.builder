xml.instruct!
xml.Response do
  xml.Gather do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      We're sorry #{@client.first_name},
      that is the incorrect PIN number for your account.
      Please re-enter your PIN number
      I'm sorry, the PIN number you entered is invalid.
      Please enter your PIN number and press pound.
    EOS
  end
end
