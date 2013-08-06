require 'spec_helper'

describe ClientCall do
  let!(:client)         { FactoryGirl.create(:client) }
  let!(:call)           { FactoryGirl.create(:client_call, client: client) }

  describe ".process_calls" do
    let!(:processed_call) { FactoryGirl.create(:processed_call, client: client) }

    before do
      Rails.configuration.twilio = {account_sid: "account", auth_token: "token"}

      call.stub(:send_statistics)
      ClientCall.stub(unprocessed: [call])

      VCR.use_cassette("twilio-call") do
        ClientCall.process_calls
      end
    end

    it "processes unprocessed calls" do
      expect(ClientCall.find(call.id)).to be_processed
    end

    it "rounds duration" do
      expect(call.duration).to eql(2)
    end

    it "save fields correctly" do
      expect(call.date_created).to eql("Wed, 17 Jul 2013 23:50:32 +0000")
      expect(call.date_updated).to eql("Wed, 17 Jul 2013 23:51:57 +0000")
      expect(call.account_sid).to eql("AC4d5e48e4d4647262b5c4314e36e3d26e")
      expect(call.to).to eql("+15186335473")
      expect(call.from).to eql("+17863295532")
      expect(call.phone_number_sid).to eql("PN9523396e26f2d67f4375b7c67599a191")
      expect(call.status).to eql("completed")
      expect(call.start_time).to eql("Wed, 17 Jul 2013 23:50:32 +0000")
      expect(call.end_time).to eql("Wed, 17 Jul 2013 23:51:57 +0000")
      expect(call.original_duration).to eql("85")
      expect(call.price).to eql("-0.02000")
      expect(call.price_unit).to eql("USD")
      expect(call.direction).to eql("inbound")
    end

    it "discount duration from client minutes" do
      client.reload
      expect(client.minutes).to eql(58)
    end

    it "calls send_statistics" do
      expect(call).to have_received(:send_statistics)
    end
  end

  describe "#send_statistics" do
    it "sends call statistics to the client and to the psychic" do
      expect { call.send_statistics }.to change { Sidekiq::Extensions::DelayedMailer.jobs.size }.by(2)
    end
  end

  describe "#duration_str" do
    context "when minutes > 1" do
      let(:call) { ClientCall.new(duration: 2) }
      it "returns 'minutes'" do
        expect(call.duration_str).to eql("2 minutes")
      end
    end

    context "when minutes = 1" do
      let(:call) { ClientCall.new(duration: 1) }
      it "returns 'minute'" do
        expect(call.duration_str).to eql("1 minute")
      end
    end

    context "when minutes = 0" do
      let(:call) { ClientCall.new(duration: 0) }
      it "returns 'no minutes'" do
        expect(call.duration_str).to eql("no minutes")
      end
    end
  end
end
