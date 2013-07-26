module CallsHelper
  def calls_url_for(action, number, psychic=nil)
    action, query = *action.split("?")
    psychic_qs = "&psychic_id=#{psychic.id}" if psychic

    query = "&#{query}" if query.present?
    "/calls/#{action}.xml?From=#{CGI.escape(number)}#{psychic_qs}#{query}"
  end

  def price_to_phrase(price)
    if price.to_i.to_f == price.to_f
      dollars = price.to_i
      cents = 0
    else
      dollars, cents = *price.to_s.split(".")
      dollars = dollars.to_i
      cents = cents.to_i
    end

    phrase = ""
    dollars_word = dollars > 1 ? "dollars" : "dollar"
    cents_word = cents > 1 ? "cents" : "cent"
    phrase << "#{dollars} #{dollars_word} " if dollars > 0
    phrase << "#{cents} #{cents_word}" if cents > 0
    phrase.strip
  end
end
