xml.instruct!
xml.Response do
  xml.Gather(action: calls_url_for("transfer", phone_number)) do
    xml.Say <<-EOS, voice: "woman"
      Thank you.
      Please enter the four digit extension of your psychic followed by the pound sign.
    EOS
  end
end
