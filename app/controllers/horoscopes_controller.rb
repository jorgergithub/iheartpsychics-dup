class HoroscopesController < ApplicationController
  layout "main"
  
  before_action :build_new_user

  def index
    @horoscope = Horoscope.last_by_date
    @lovescope_horoscope = Horoscope.last_lovescope_horoscope
  end
end
