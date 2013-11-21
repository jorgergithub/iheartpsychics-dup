class Horoscope < ActiveRecord::Base
  Aries       = Sign.new("Aries",       Date.new(2014,3,21), Date.new(2014,4,19))
  Taurus      = Sign.new("Taurus",      Date.new(2014,4,20), Date.new(2014,5,20))
  Gemini      = Sign.new("Gemini",      Date.new(2014,5,21), Date.new(2014,6,21))
  Cancer      = Sign.new("Cancer",      Date.new(2014,6,22), Date.new(2014,7,22))
  Leo         = Sign.new("Leo",         Date.new(2014,7,23), Date.new(2014,8,22))
  Virgo       = Sign.new("Virgo",       Date.new(2014,3,21), Date.new(2014,4,21))
  Libra       = Sign.new("Libra",       Date.new(2014,4,20), Date.new(2014,5,20))
  Sagittarius = Sign.new("Sagittarius", Date.new(2014,4,20), Date.new(2014,5,20))
  Scorpio     = Sign.new("Scorpio",     Date.new(2014,4,20), Date.new(2014,5,20))
  Capricorn   = Sign.new("Capricorn",   Date.new(2014,4,20), Date.new(2014,5,20))
  Aquarius    = Sign.new("Aquarius",    Date.new(2014,4,20), Date.new(2014,5,20))
  Pisces      = Sign.new("Pisces",      Date.new(2014,4,20), Date.new(2014,5,20))

  SIGNS = [ Aries, Taurus, Gemini, Cancer, Leo, Virgo, 
            Libra, Sagittarius, Scorpio, Capricorn, Aquarius, Pisces ]

  def signs
    SIGNS.map { |sign| sign.horoscope = self; sign }
  end
end
