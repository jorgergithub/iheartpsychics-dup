xml.instruct!
xml.Response do
  xml.Gather(action: calls_url_for("do_transfer", phone_number, @psychic), numDigits: 1) do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      You've requested to speak with #{@psychic.alias_name}
      at a rate of #{price_to_phrase @psychic.price} per minute.
      Based on your balance, you have #{@client.minutes_with(@psychic)} minutes
      available with this reader.
      If this is correct, press one.
      If not, press two.
    EOS
  end
end
