require 'spec_helper'

describe HoroscopesController do
  describe "GET 'index'" do
    let!(:first_horoscope) { FactoryGirl.create :horoscope, date: Date.yesterday }
    let!(:last_horoscope) { FactoryGirl.create :horoscope }

    it "assigns last horoscope" do
      get :index
      expect(assigns[:horoscope]).to be_eql last_horoscope
    end
  end
end
