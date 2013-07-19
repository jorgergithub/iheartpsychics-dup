xml.instruct!
xml.Response do
  xml.Say "Thank you. Please wait while we transfer you to #{@psychic.first_name} #{@psychic.last_name}.",
    voice: "woman"
  xml.Dial(@psychic.phone,
    callerId: @caller_id, record: "true", timeLimit: @client.seconds,
    action: calls_url_for("call_finished", phone_number))
end
