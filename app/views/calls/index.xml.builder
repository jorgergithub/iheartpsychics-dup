xml.instruct!
xml.Response do
  if @client
    xml.Gather(action: calls_url_for("pin", phone_number)) do
      xml.Say <<-EOS.strip_heredoc, voice: "woman"
        Welcome back to I Heart Psychics #{@client.first_name}.
        Please enter your PIN number to validate your account
        and press pound.
      EOS
    end
  else
    xml.Gather(action: calls_url_for("user", phone_number)) do
      xml.Say <<-EOS.strip_heredoc, voice: "woman"
        Please enter your phone number associated with your
        I Heart Psychics account and press pound.
        Otherwise press Zero to be connected to the
        Customer Care Department.
      EOS
    end
  end
end
