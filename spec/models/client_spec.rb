require "spec_helper"

describe Client do
  let(:user)   { User.create(email: "felipe.coury@gmail.com", password: "pass123")}
  let(:client) { Client.create(user: user, pin: "12345", minutes: 60) }

  describe "#valid_pin?" do
    it "is true when PIN matches" do
      expect(client.valid_pin?("12345")).to be_true
    end

    it "is false when PIN mismatches" do
      expect(client.valid_pin?("12344")).to be_false
    end
  end

  describe "#discount_minutes" do
    before { client.discount_minutes(10) }

    it "removes minutes" do
      expect(client.minutes).to eql(50)
    end

    it "saves the minutes" do
      client.reload
      expect(client.minutes).to eql(50)
    end
  end

  describe "#seconds" do
    it "is the number of minutes, but in seconds" do
      expect(Client.new(minutes: 1).seconds).to eql(60)
      expect(Client.new(minutes: 2).seconds).to eql(120)
      expect(Client.new(minutes: 25).seconds).to eql(1500)
    end
  end
end
