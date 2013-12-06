xml.instruct!
xml.Response do
  xml.Gather(timeout: 15) do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      We're sorry #{@client.first_name},
      that is the incorrect PIN number for your account.
      Please re-enter your PIN number
    EOS
  end
end
