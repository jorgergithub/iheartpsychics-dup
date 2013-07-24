xml.instruct!
xml.Response do
  xml.Gather(action: calls_url_for("pin", @phone_number)) do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      Welcome back to I Heart Psychic #{@client.first_name}.
      Please enter your PIN to validate your account and press pound.
    EOS
  end
end
