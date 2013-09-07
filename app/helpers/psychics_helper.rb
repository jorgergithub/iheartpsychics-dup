module PsychicsHelper
  def psychic_prices
    values = Array(4.upto(7))

    values.inject([]) do |h, v|
      h << [number_to_currency(v), number_with_precision(v)]
      h << [number_to_currency(v + 0.5), number_with_precision(v + 0.5)]
      h
    end
  end

  def rating_for(psychic, options={})
    filled_icon = options[:filled_icon] || "icon-star"
    empty_icon = options[:empty_icon] || "icon-star"

    result = ""
    psychic.rating.to_i.times do
      result << "<i class='#{filled_icon} star-filled'></i> "
    end

    psychic.rating.to_i.upto(4) do
      result << "<i class='#{empty_icon} star-empty'></i> "
    end

    result << "(#{psychic.reviews.count})"
    result.html_safe
  end
end
