xml.instruct!
xml.Response do
  xml.Say "Please wait wh", voice: "woman"
  xml.Dial(@csr.phone, callerId: @caller_id, record: "true")
end
