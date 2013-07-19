require "spec_helper"

describe Client do
  let(:user)   { User.create(email: "felipe.coury@gmail.com", password: "pass123")}
  let(:client) { Client.create(user: user, pin: "1234", minutes: 60) }

  describe "creating a client with a phone number" do
    let!(:client) {
      Client.create(user: user, pin: "1234", phone_number: "7641233322")
    }

    it "saves the phone number" do
      client.reload
      client.phones.first.number.should == "+17641233322"
    end
  end

  describe "#pin" do
    it "saves the encrypted pin" do
      client.reload
      expect(client.encrypted_pin).not_to be_nil
      expect(client.encrypted_pin).not_to be_empty
    end

    it "allows resetting the pin" do
      client.reload
      client.pin = "1232"
      client.save
      expect(client.valid_pin?("1232")).to be_true
    end
  end

  describe "#valid_pin?" do
    it "is true when PIN matches" do
      expect(client.valid_pin?("1234")).to be_true
    end

    it "is false when PIN mismatches" do
      expect(client.valid_pin?("1234")).to be_false
    end
  end

  describe "#add_minutes" do
    context "with an user with no minutes" do
      before do
        client.update_attributes(minutes: nil)
        client.add_minutes(10)
      end

      it "removes minutes" do
        expect(client.minutes).to eql(10)
      end
    end

    context "with an user with minutes" do
      before { client.add_minutes(10) }

      it "removes minutes" do
        expect(client.minutes).to eql(70)
      end

      it "saves the minutes" do
        client.reload
        expect(client.minutes).to eql(70)
      end
    end

    context "with a string as parameter" do
      it "works" do
        client.add_minutes("10")
        expect(client.minutes).to eql(70)
      end
    end
  end

  describe "#discount_minutes" do
    context "with an user with no minutes" do
      before do
        client.update_attributes(minutes: nil)
        client.discount_minutes(10)
      end

      it "removes minutes" do
        expect(client.minutes).to eql(-10)
      end
    end

    context "with an user with minutes" do
      before { client.discount_minutes(10) }

      it "removes minutes" do
        expect(client.minutes).to eql(50)
      end

      it "saves the minutes" do
        client.reload
        expect(client.minutes).to eql(50)
      end
    end

    context "with a string as parameter" do
      it "works" do
        client.discount_minutes("10")
        expect(client.minutes).to eql(50)
      end
    end

    context "with an user with zero minutes" do
      pending
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
