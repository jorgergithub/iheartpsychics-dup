require "spec_helper"

describe User do
  describe "creating user as a clint" do
    let(:user) { create(:user, create_as: "client") }

    it "creates the client" do
      expect(user.client).to_not be_nil
    end

    it "creates the user with client role" do
      expect(user.role).to eql("client")
    end

    it "returns true to client?" do
      expect(user).to be_client
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
