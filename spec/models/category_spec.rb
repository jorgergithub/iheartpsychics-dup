require "spec_helper"

describe Category do
  it { should have_many :faqs }

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
