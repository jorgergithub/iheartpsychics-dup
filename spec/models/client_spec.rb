require "spec_helper"

describe Client do
  let(:user)   { User.create(email: "felipe.coury@gmail.com", password: "pass123")}
  let(:client) { Client.create(user: user, pin: "12345") }

  describe "#valid_pin?" do
    it "is true when PIN matches" do
      expect(client.valid_pin?("12345")).to be_true
    end

    it "is false when PIN mismatches" do
      expect(client.valid_pin?("12344")).to be_false
    end
  end
end
