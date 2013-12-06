xml.instruct!
xml.Response do
  xml.Gather(action: calls_url_for("buy_credits", phone_number), timeout: 15) do
    i = 1
    @packages.each do |pkg|
      xml.Say <<-EOS.strip_heredoc, voice: "woman"
        Press #{i} to add #{pkg.credits} dollars to your account
        for #{price_to_phrase(pkg.price)}.
      EOS
      i += 1
    end
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      Press #{i} to speak to a customer service representative.
    EOS
    xml.Say <<-EOS.strip_heredoc, voice: "woman"
      Press #{i+1} to disconnect.
    EOS
  end
end
