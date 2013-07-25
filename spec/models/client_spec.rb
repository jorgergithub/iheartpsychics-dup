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

  describe "creating a client" do
    let!(:client) { Client.create(user: user) }

    it "creates a random PIN number" do
      expect(client.reload.encrypted_pin).to_not be_nil
    end
  end

  describe "deleting a client" do
    context "with a phone" do
      let!(:user) { FactoryGirl.create(:user, phone_number: "7641233322", create_as: "client") }
      let!(:client) { user.client }
      let!(:phone) { client.phones.first }

      it "deletes the phone" do
        user.destroy
        expect { ClientPhone.find(phone.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
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
      expect(client.valid_pin?("1233")).to be_false
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
    let(:call)   { FactoryGirl.create(:client_call) }
    let(:credit) { client.credits.first }

    context "with an user with no minutes" do
      before do
        client.update_attributes(minutes: nil)
        client.discount_minutes(10, call)
      end

      it "removes minutes" do
        expect(client.minutes).to eql(-10)
      end

      it "records the credit summary" do
        expect(credit.description).to eql("Call with John Doe")
        expect(credit.minutes).to eql(-10)
      end
    end

    context "with an user with minutes" do
      before { client.discount_minutes(10, call) }

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
        client.discount_minutes("10", call)
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

  describe "#stripe_client" do
    let(:stripe_client) { double("stripe_client").as_null_object }

    context "when stripe_client_id is nil" do
      let(:client) { FactoryGirl.create(:client) }

      context "when omitting reload" do
        before {
          stripe_client.stub(id: "abc123")
          Stripe::Customer.stub(:create => stripe_client)
        }

        it "creates a new customer" do
          expect(client.stripe_client).to eql(stripe_client)
        end

        it "creates the new customer with a description" do
          desc = { description: "#{client.id} - #{client.full_name} (#{client.username})" }
          Stripe::Customer.should_receive(:create).with(hash_including(desc))
          client.stripe_client
        end

        it "saves the new client id" do
          client.stripe_client
          expect(client.stripe_client_id).to eql("abc123")
        end
      end
    end

    context "when stripe_client_id isn't nil" do
      let(:client) { FactoryGirl.create(:client, stripe_client_id: "abc123") }

      before { Stripe::Customer.stub(retrieve: stripe_client) }

      it "returns the stripe client" do
        expect(client.stripe_client).to eql(stripe_client)
      end

      context "when omitting reload" do
        it "caches the stripe client instance" do
          Stripe::Customer.should_receive(:retrieve).once
          client.stripe_client
          client.stripe_client
        end
      end

      context "when reload is true" do
        it "doesn't cache the stripe client instance" do
          Stripe::Customer.should_receive(:retrieve).twice
          client.stripe_client
          client.stripe_client(true)
        end
      end
    end
  end

  describe "#charge" do
    let(:stripe_client) { double(:stripe_client, id: "abc123") }
    let(:charge) { double(:charge, id: "charge_id") }
    let(:transaction) { client.transactions.take }

    before {
      client.stub(stripe_client: stripe_client)
      Stripe::Charge.stub(:create => charge)
    }

    context "when charge succeeds" do
      it "charges the stripe client id" do
        info = { customer: "abc123" }
        Stripe::Charge.should_receive(:create).with(hash_including(info))
        client.charge(100, "something")
      end

      it "charges the given amount" do
        info = { amount: 10002 }
        Stripe::Charge.should_receive(:create).with(hash_including(info))
        client.charge(100.02, "something")
      end

      it "charges with the given description" do
        info = { description: "something" }
        Stripe::Charge.should_receive(:create).with(hash_including(info))
        client.charge(100.02, "something")
      end

      it "charges in USD" do
        info = { currency: "usd" }
        Stripe::Charge.should_receive(:create).with(hash_including(info))
        client.charge(100.02, "something")
      end

      it "returns the charge object" do
        expect(client.charge(100, "something")).to eql(charge)
      end

      describe "transaction" do
        before { client.charge(100, "something") }

        it "creates one transaction" do
          expect(client.transactions.size).to eql(1)
        end

        it "sets operation" do
          expect(transaction.operation).to eql("charge")
        end

        it "sets success" do
          expect(transaction).to be_success
        end

        it "sets the charge id" do
          expect(transaction.transaction_id).to eql("charge_id")
        end
      end
    end

    context "when there are charging errors" do
      before {
        error = "(Status 402) Cannot charge a customer that has no active card"
        exception = Stripe::CardError.new(error, "param", "code")
        Stripe::Charge.stub(:create).and_raise(exception)
      }

      it "raises the error" do
        expect {
          client.charge(100, "something")
        }.to raise_error(Stripe::CardError)
      end
    end
  end

  describe "#add_card_from_token" do
    let(:card) { double(:card) }
    let(:stripe_client) { double(:stripe_client).as_null_object }
    let(:stripe_cards) { double(:stripe_cards).as_null_object }

    before {
      client.stub(stripe_client: stripe_client)
      client.stub(:save_cards)
      stripe_client.stub(cards: stripe_cards)
    }

    it "updates the card" do
      stripe_client.should_receive(:card=).with("tok_2FgDgRXOFFXjtW")
      client.add_card_from_token("tok_2FgDgRXOFFXjtW")
    end

    it "saves the card" do
      stripe_client.should_receive(:save)
      client.add_card_from_token("tok_2FgDgRXOFFXjtW")
    end

    it "saves the customer cards" do
      client.should_receive(:save_cards)
      client.add_card_from_token("tok_2FgDgRXOFFXjtW")
    end
  end

  describe "#save_cards" do
    let(:stripe_card) { double(:stripe_card) }
    let(:stripe_client) { double(:stripe_client, cards: [stripe_card]) }

    let(:card) { client.reload.cards.take }

    before {
      stripe_card.stub(id: "cc_2G2L06vvQS1BKY")
      stripe_card.stub(to_hash: {
        id: "cc_2G2L06vvQS1BKY",
        object: "card",
        last4: "4242",
        type: "Visa",
        exp_month: 7,
        exp_year: 2014,
        fingerprint: "3DdmECgaaL5RtYzn",
        customer: "cus_2Fzi6yfxE0y7bB",
        country: "US",
        address_city: nil,
        cvc_check: "pass"})

      client.cards.create
      client.stub(stripe_client: stripe_client)
    }

    it "reloads the client" do
      client.should_receive(:stripe_client).with(true)
      client.save_cards
    end

    context "after saving the card" do
      before { client.save_cards }

      it "creates a new card" do
        expect(client.cards.size).to eql(1)
      end

      it "assigns stripe_id" do
        expect(card.stripe_id).to eql("cc_2G2L06vvQS1BKY")
      end

      it "assigns last4" do
        expect(card.last4).to eql("4242")
      end

      it "assigns type" do
        expect(card.type).to eql("Visa")
      end

      it "assigns exp_month" do
        expect(card.exp_month).to eql(7)
      end

      it "assigns exp_year" do
        expect(card.exp_year).to eql(2014)
      end

      it "assigns country" do
        expect(card.country).to eql("US")
      end

      it "assigns address_city" do
        expect(card.address_city).to be_nil
      end
    end
  end
end
