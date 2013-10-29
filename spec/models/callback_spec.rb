require "spec_helper"

describe Callback do
  it { should belong_to :psychic }
  it { should belong_to :client }

  describe "#expired?" do
    before { Timecop.freeze(Time.zone.parse("2013-09-28 00:00")) }
    after { Timecop.return }

    it "is false if expires_at is in the future" do
      subject.expires_at = Time.now + 1.second
      expect(subject).to_not be_expired
    end

    it "is true if expires_at is in the past" do
      subject.expires_at = Time.now - 1.second
      expect(subject).to be_expired
    end

    it "is true if expires_at is now" do
      subject.expires_at = Time.now
      expect(subject).to be_expired
    end

    it "is false if expires_at is null" do
      subject.expires_at = nil
      expect(subject).to_not be_expired
    end
  end
end
