require "spec_helper"

describe Psychic do
  it { should belong_to :user }

  it { should have_many :calls }
  it { should have_many :reviews }

  it { should delegate(:email).to(:user).allowing_nil(true) }
  it { should delegate(:first_name).to(:user).allowing_nil(true) }
  it { should delegate(:full_name).to(:user).allowing_nil(true) }
  it { should delegate(:last_name).to(:user).allowing_nil(true) }
  it { should delegate(:username).to(:user).allowing_nil(true) }

  describe "validations" do
    it { should validate_presence_of(:pseudonym) }
    it { should validate_presence_of(:phone) }
    it { should validate_as_phone_number(:phone) }
    it { should validate_uniqueness_of(:extension) }
  end

  describe "#specialties" do
    it "returns the specialties as string" do
      subject.specialties_love_and_relationships = true
      subject.specialties_deceased = true

      expect(subject.specialties).to eq "love and relationships, deceased"
    end
  end

  describe "#alias_name" do
    it "returns pseudonym with first letter of last name" do
      subject.stub(:last_name => "Tracy")
      subject.pseudonym = "Jack"

      expect(subject.alias_name).to eq "Jack T"
    end
  end

  context "availability" do
    let(:psychic) { create(:psychic) }

    describe "#available?" do
      context "when there are no hour entries" do
        it "is false" do
          expect(psychic).to_not be_available
        end
      end

      context "when last hour entry has start action" do
        before { psychic.available! }
        it "is true" do
          expect(psychic).to be_available
        end
      end

      context "when status is unavailable" do
        before { psychic.unavailable! }
        it "is false" do
          expect(psychic).to_not be_available
        end
      end
    end

    describe "#available!" do
      before {
        psychic.available!
      }
      it "makes the psychic available" do
        expect(psychic).to be_available
      end
    end

    describe "#unavailable!" do
      before {
        psychic.unavailable!
      }
      it "makes the psychic unavailable" do
        expect(psychic).to_not be_available
      end
    end
  end
end
