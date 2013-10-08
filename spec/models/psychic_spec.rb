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
end
