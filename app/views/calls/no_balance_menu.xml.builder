xml.instruct!
xml.Response do
  xml.Gather(action: calls_url_for("topup", phone_number), numDigits: 1, timeout: 15) do
    xml.Say "You have run out of dollars on your account.", voice: "woman"
    if @client.cards.try(:any?)
      xml.Say <<-EOS.strip_heredoc, voice: "woman"
        Please press 1 to purchase more dollars.
      EOS
    end
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      Press 2 to speak to a customer service representative.
      Press 3 to disconnect.
    EOS
  end
end
