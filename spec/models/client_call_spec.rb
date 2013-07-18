require 'spec_helper'

describe ClientCall do
  describe ".process_calls" do
    let!(:client)         { FactoryGirl.create(:client) }
    let!(:processed_call) { FactoryGirl.create(:processed_call, client: client) }
    let!(:call)           { FactoryGirl.create(:client_call, client: client) }

    before do
      VCR.use_cassette("twilio-call") do
        ClientCall.process_calls
      end

      call.reload
    end

    it "processes unprocessed calls" do
      expect(call).to be_processed
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
  end
end
