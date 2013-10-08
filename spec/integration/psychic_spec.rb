require "spec_helper"

describe Psychic do
  describe "#assign_extension" do
    let(:psychic) { FactoryGirl.create(:psychic) }

    it "assigns a random extension when creating" do
      RandomUtils.stub(:random_extension => "1234")
      expect(psychic.extension).to eq "1234"
    end
  end

  describe "#featured_review" do
    let(:psychic) { create(:psychic) }

    it "returns first review marked as featured" do
      featured_review = create(:featured_review, psychic: psychic)
      review = create(:review, psychic: psychic)

      expect(psychic.featured_review).to eq featured_review
    end
  end
end
