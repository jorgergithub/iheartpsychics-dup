require "spec_helper"

describe Psychic do
  it { should belong_to :user }

  it { should have_many :calls }
  it { should have_many :reviews }
  it { should have_many :callbacks }

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

  describe "sign" do
    it "delegates sign to Sign class" do
      subject.date_of_birth = Sign::Aries.first_day
      expect(subject.sign).to be_eql Sign::Aries
    end
  end

  describe "#assign_extension" do
    it "assigns a random extension when creating" do
      RandomUtils.stub(:random_extension => "1234")

      subject.run_callbacks(:create)

      expect(subject.extension).to_not be_nil
      expect(subject.extension).to eq "1234"
    end
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

  describe "#can_callback?" do
    let(:psychic) { create(:psychic) }
    let(:user) { create(:user, create_as: "client") }
    let(:client) { user.client }

    before { client.balance = psychic.price * 10 }

    it "returns false if psychic is available" do
      psychic.stub(available?: true)
      expect(psychic.can_callback?(client)).to be_false
    end

    it "returns false if client balance is less than 10 minutes worth of psychic time" do
      client.balance = (psychic.price * 10) - 0.01
      expect(psychic.can_callback?(client)).to be_false
    end

    it "returns true if client balance is exactly 10 minutes worth of psychic time" do
      expect(psychic.can_callback?(client)).to be_true
    end

    it "returns true if client balance is more than 10 minutes worth of psychic time" do
      client.balance = (psychic.price * 10) + 0.01
      expect(psychic.can_callback?(client)).to be_true
    end
  end

  describe "#call" do
    let(:psychic) { build(:psychic, phone: "+13054502995") }
    let(:calls) { double(:calls) }
    let(:twilio_account) { double(:twilio_account) }

    before {
      calls.stub(:create)
      twilio_account.stub(calls: calls)
      psychic.stub(twilio_account: twilio_account)
    }

    it "calls the psychic number using Twilio" do
      psychic.call("URL")
      calls.should have_received(:create).with(from: "+17863295532", to: "+13054502995", url: "URL")
    end
  end

  describe "#total_calls_in_period" do
    let!(:psychic) { create(:psychic) }
    let!(:call) { create(:call, psychic: psychic) }
    let!(:invoice) { create(:invoice) }
    let!(:invoiced_call) { create(:call, psychic: psychic, invoice: invoice) }

    it "reports the number of uninvoiced calls" do
      expect(psychic.total_calls_in_period).to eql(1)
    end
  end

  describe "#total_minutes_in_period" do
    let!(:psychic) { create(:psychic) }
    let!(:call) { create(:call, psychic: psychic, original_duration: 10 * 60) }
    let!(:call2) { create(:call, psychic: psychic, original_duration: 15 * 60) }
    let!(:invoice) { create(:invoice) }
    let!(:invoiced_call) { create(:call, psychic: psychic, invoice: invoice, original_duration: 25 * 60) }

    it "reports the sum of the duration of uninvoiced calls" do
      expect(psychic.total_minutes_in_period).to eql(25)
    end
  end

  describe "#avg_minutes_per_call_in_period" do
    let!(:psychic) { create(:psychic) }
    let!(:call) { create(:call, psychic: psychic, original_duration: 10 * 60) }
    let!(:call2) { create(:call, psychic: psychic, original_duration: 15 * 60) }
    let!(:invoice) { create(:invoice) }
    let!(:invoiced_call) { create(:call, psychic: psychic, invoice: invoice, original_duration: 25 * 60) }

    it "reports the average minutes per call" do
      expect(psychic.avg_minutes_in_period).to eql(12)
    end
  end

  describe "#current_tier" do
    let(:psychic) { build(:psychic) }
    let(:tier) { double(:tier) }

    before do
      Tier.stub(for: tier)
      psychic.stub(total_minutes_in_period: 38)
      @tier = psychic.current_tier
    end

    it "returns the tier" do
      expect(@tier).to eql(tier)
    end

    it "queries the tier for the current total minutes" do
      expect(Tier).to have_received(:for).with(38)
    end
  end

  describe "#payout_percentage_in_period" do
    let(:psychic) { build(:psychic) }
    let(:tier) { double(:tier) }

    before do
      tier.stub(percent: 21)
      psychic.stub(current_tier: tier)
    end

    it "returns the tier's percentage" do
      expect(psychic.payout_percentage_in_period).to eql(21)
    end
  end
end
