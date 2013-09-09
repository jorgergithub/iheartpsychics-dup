require "spec_helper"

describe Psychic do
  describe "#featured_review" do
    let(:psychic) { create(:psychic) }

    it "returns first review marked as festured" do
      featured_review = create(:featured_review, psychic: psychic)
      review = create(:review, psychic: psychic)

      expect(psychic.featured_review).to eq featured_review
    end
  end
end
