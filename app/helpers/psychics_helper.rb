module PsychicsHelper
  def psychic_prices
    values = *4.upto(7)
    values.inject([]) do |h, v|
      h << [number_to_currency(v), v]
      h << [number_to_currency(v+0.5), v+0.5]
      h
    end
  end
end
