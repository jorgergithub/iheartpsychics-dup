require "spec_helper"

describe CallbackMailer do
  describe "notify_client" do
    let(:mail) { CallbackMailer.notify_client }

    it "renders the headers" do
      mail.subject.should eq("Notify client")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
