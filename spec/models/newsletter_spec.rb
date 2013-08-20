require "spec_helper"

describe Newsletter do
  let!(:newsletter) { FactoryGirl.create(:newsletter, deliver_by: Date.today) }

  describe ".deliver_all" do
    let!(:newsletter2) { FactoryGirl.create(:newsletter, deliver_by: Date.today - 1.day) }

    before { Newsletter.deliver_all }

    it "delivers today's newsletters" do
      expect(newsletter.reload).to be_delivered
    end

    it "doesn't deliver other day's newsletters" do
      expect(newsletter2.reload).to_not be_delivered
    end
  end

  describe "#deliver" do
    let(:client1) { FactoryGirl.create(:client) }
    let(:client2) { FactoryGirl.create(:client) }

    before {
      Client.stub(all: [client1, client2])
      NewsletterMailer.stub(:send_newsletter)
      newsletter.deliver
    }

    it "sends an email to each client" do
      NewsletterMailer.should have_received(:send_newsletter).with(newsletter, client1)
      NewsletterMailer.should have_received(:send_newsletter).with(newsletter, client2)
    end

    it "sets delivered to true" do
      expect(newsletter.reload).to be_delivered
    end
  end
end
