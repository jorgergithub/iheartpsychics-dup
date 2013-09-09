require "spec_helper"

describe Review do
  describe "#mark_as_featured!" do
    let(:psychic) { create(:psychic) }

    it "sets true to featured" do
      review = create(:review, psychic: psychic)
      review.mark_as_featured!

      expect(review).to be_featured
    end

    it "unmark other as featured" do
      featured_review = create(:featured_review, psychic: psychic)
      review = create(:review, psychic: psychic)
      review.mark_as_featured!

      expect(featured_review.reload).to_not be_featured
    end
  end
end
