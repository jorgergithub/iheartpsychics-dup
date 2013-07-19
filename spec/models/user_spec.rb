require "spec_helper"

describe User do
  describe "creating a client with a phone number" do
    let(:user) { User.create(email: "felipe.coury@gmail.com", password: "teste123", phone_number: "3054502983", create_as: "client") }

    it "creates the client" do
      expect(user.client).to_not be_nil
    end

    it "creats a client with a phone number" do
      user.client.phones.first.number.should == "+13054502983"
    end
  end

  describe "creating a psychic" do
    let(:user) { User.create(email: "felipe.coury@gmail.com", password: "teste123", phone_number: "3054502983", create_as: "psychic") }

    it "creates the psychic" do
      expect(user.psychic).to_not be_nil
    end
  end

  describe "#full_name" do
    let(:user) { User.new(first_name: "Felipe", last_name: "Coury") }
    it "joins first and last names" do
      expect(user.full_name).to eql("Felipe Coury")
    end
  end

  describe "#client?" do
    let(:user) { User.new }

    it "is false when user has no client" do
      expect(user).to_not be_client
    end

    it "is true when user has a client" do
      user.client = Client.new
      expect(user).to be_client
    end
  end

  describe "#psychic?" do
    let(:user) { User.new }

    it "is false when user has no psychic" do
      expect(user).to_not be_psychic
    end

    it "is true when user has a psychic" do
      user.psychic = Psychic.new
      expect(user).to be_psychic
    end
  end
end
