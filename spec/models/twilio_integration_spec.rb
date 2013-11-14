require "spec_helper"
require "twilio"

describe TwilioIntegration do
  subject { Object.new.extend(TwilioIntegration) }

  describe "#create_call" do
    let(:twilio_account) { double(:twilio_account) }
    let(:calls) { double(:calls) }

    before {
      subject.stub(twilio_account: twilio_account)
      twilio_account.stub(calls: calls)
      calls.stub(:create)
    }

    it "uses twilio account to create a call" do
      subject.create_call("8888", "URL")
      expect(calls).to have_received(:create).with(from: "+17863295532", to: "8888", url: "URL")
    end
  end

  describe "#twilio_account" do
    let(:client) { double(:client) }
    let(:account) { double(:account) }

    before {
      TwilioHelper.stub(client: client)
      client.stub(account: account)
    }

    it "returns the account" do
      expect(subject.twilio_account).to eql(account)
    end
  end

  describe "#get_call" do
    let(:twilio_account) { double(:twilio_account) }
    let(:calls) { double(:calls) }

    before {
      subject.stub(twilio_account: twilio_account)
      twilio_account.stub(calls: calls)
      calls.stub(:get)

      subject.get_call("CALL_SID")
    }

    it "gets the call" do
      expect(calls).to have_received(:get).with("CALL_SID")
    end
  end

  describe "#modify_call" do
    let(:call) { double(:call) }
    let(:status) { "STATUS" }

    before {
      subject.stub(get_call: call)
      call.stub(:redirect_to)
      call.stub(status: status)

      subject.modify_call("CALL_SID", "URL")
    }

    it "retrieves the correct call" do
      expect(subject).to have_received(:get_call).with("CALL_SID")
    end

    context "when call is in progress" do
      let(:status) { "in-progress" }

      it "redirects the call" do
        expect(call).to have_received(:redirect_to).with("URL")
      end
    end

    context "when call is in other state" do
      let(:status) { "other" }

      it "doesn't redirect the call" do
        expect(call).to_not have_received(:redirect_to).with("URL")
      end
    end
  end
end
