require "spec_helper"

describe Psychic do
  let(:user)    { FactoryGirl.create(:user) }

  context "when random extension is unique" do
    let(:psychic) { Psychic.create(user: user) }

    it "assigns a random extension when creating" do
      RandomUtils.stub(:random_extension => "1234")
      expect(psychic.extension).to eql("1234")
    end
  end

  context "#extension" do
    before {
      Psychic.create(user: user, extension: "0010")
    }

    let(:psychic) { Psychic.new(user: user, extension: "0010") }

    it "must be unique" do
      expect(psychic).not_to be_valid
      expect(psychic.errors.messages).to eql(extension: ["has already been taken"])
    end
  end
end
