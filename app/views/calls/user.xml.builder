xml.instruct!
xml.Response do
  xml.Gather(action: calls_url_for("pin", @phone_number), timeout: 15) do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      Welcome back to I Heart Psychics #{@client.first_name}.
      Please enter your PIN to validate your account and press pound.
    EOS
  end
end
