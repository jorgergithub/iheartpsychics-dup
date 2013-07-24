xml.instruct!
xml.Response do
  xml.Gather(action: calls_url_for("transfer", phone_number)) do
    xml.Say <<-EOS, voice: "woman"
      Thank you #{@client.first_name}.
      Please enter the extension of the psychic you wish to contact
      and press pound.
    EOS
  end
end
