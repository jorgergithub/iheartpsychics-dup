class HoroscopesController < ApplicationController
  layout "main"

  def index
    @horoscope = Horoscope.last
  end
end
