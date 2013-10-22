xml.instruct!
xml.Response do
  xml.Say "Thank you. Please wait while we transfer you to #{@psychic.alias_name}.",
    voice: "woman"
  xml.Dial(@psychic.phone,
    callerId: @caller_id, record: "true", timeLimit: @client.seconds(@psychic),
    action: calls_url_for("call_finished", phone_number, @psychic))
end
