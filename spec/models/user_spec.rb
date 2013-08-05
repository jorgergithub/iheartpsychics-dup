require "spec_helper"

describe User do
  describe "creating a client with a phone number" do
    let(:user) { FactoryGirl.create(:user, phone_number: "3054502983", create_as: "client") }

    it "creates the client" do
      expect(user.client).to_not be_nil
    end

    it "creats a client with a phone number" do
      user.client.phones.first.number.should == "+13054502983"
    end

    it "creates the user with client role" do
      expect(user.role).to eql("client")
    end

    it "returns true to client?" do
      expect(user).to be_client
    end
  end

  describe "creating a psychic" do
    let(:user) { FactoryGirl.create(:user, create_as: "psychic") }

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

  describe "deleting an user with a client" do
    let(:user) { FactoryGirl.create(:user, create_as: "client") }
    let(:client) { user.client }

    it "cascades the deletion to client" do
      expect(client).to_not be_nil
      user.destroy
      expect { Client.find(client.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "deleting an user with a psychic" do
    let(:user) { FactoryGirl.create(:user, create_as: "psychic") }
    let(:psychic) { user.psychic }

    it "cascades the deletion to psychic" do
      expect(psychic).to_not be_nil
      user.destroy
      expect { Psychic.find(psychic.id) }.to raise_error(ActiveRecord::RecordNotFound)
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
  end

  describe "#psychic?" do
    let(:user) { User.new }

    it "is false when user has no psychic" do
      expect(user).to_not be_psychic
    end
  end
end
