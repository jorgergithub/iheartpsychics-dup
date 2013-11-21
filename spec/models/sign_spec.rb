require "spec_helper"

describe Sign do
  let(:horoscope) { FactoryGirl.build :horoscope }
  let(:subject)   { Sign::Taurus }

  it "delegates :text to horoscope" do
    horoscope.taurus = "Taurus Horoscope"
    subject.horoscope = horoscope
    expect(subject.text).to be_eql "Taurus Horoscope"
  end
end