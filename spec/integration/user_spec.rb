require "spec_helper"

describe User do
  describe "creating a client with a phone number" do
    let(:user) { create(:user, phone_number: "+13054502983", create_as: "client") }

    it "creates the client" do
      expect(user.client).to_not be_nil
    end

    it "creates a client with a phone number" do
      user.client.phones.first.number.should == "+13054502983"
    end

    it "creates the user with client role" do
      expect(user.role).to eql("client")
    end

    it "returns true to client?" do
      expect(user).to be_client
    end

    it "validates uniqueness of phone number" do
      create(:client, phone_number: "+17641233322")

      subject.phone_number = "+17641233322"
      subject.valid?

      expect(subject.errors[:phone_number]).to include("has already been taken")
    end
  end

  describe "creating a psychic" do
    let(:user) { create(:user, create_as: "psychic") }

    it "creates the psychic" do
      expect(user.psychic).to_not be_nil
    end

    it "creates the user with psychic role" do
      expect(user.role).to eql("psychic")
    end

    it "returns true to psychic?" do
      expect(user).to be_psychic
    end
  end
end
