xml.instruct!
xml.Response do
  xml.Gather(action: calls_url_for("do_transfer", phone_number), numDigits: 1) do
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      You've requested to speak with #{@psychic.first_name} #{@psychic.last_name}.
      If this is correct, press one.
      If not, press two.
    EOS
  end
end
