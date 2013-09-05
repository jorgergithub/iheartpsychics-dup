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

  describe "#assign_extension" do
    let(:user) { FactoryGirl.create(:user) }
    let(:psychic) { Psychic.create(user: user, phone: "+15186335473") }

    it "assigns a random extension when creating" do
      RandomUtils.stub(:random_extension => "1234")
      expect(psychic.extension).to eq "1234"
    end
  end
end
