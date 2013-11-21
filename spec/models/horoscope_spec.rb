require "spec_helper"

describe Horoscope do
  describe Horoscope::SIGNS do
    it "returns a list of signs" do
      expect(Horoscope::SIGNS).to be_eql([Horoscope::Aries,
                                          Horoscope::Taurus,
                                          Horoscope::Gemini,
                                          Horoscope::Cancer,
                                          Horoscope::Leo,
                                          Horoscope::Virgo,
                                          Horoscope::Libra,
                                          Horoscope::Sagittarius,
                                          Horoscope::Scorpio,
                                          Horoscope::Capricorn,
                                          Horoscope::Aquarius,
                                          Horoscope::Pisces
                                          ])
    end
  end
end