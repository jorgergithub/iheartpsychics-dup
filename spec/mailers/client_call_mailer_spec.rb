require "spec_helper"

describe ClientCallMailer do
  let!(:client)      { FactoryGirl.create(:client, minutes: 10) }
  let!(:psychic)     { FactoryGirl.create(:psychic) }
  let!(:client_call) { FactoryGirl.create(:client_call, client: client,
                                                        psychic: psychic) }

  let(:host) { ActionMailer::Base.default_url_options[:host] }

  context "#client_call_statistics" do
    let(:email) { ClientCallMailer.client_call_statistics(client_call) }

    it "sends out the email to the client" do
      expect(email.to).to include(client.email)
    end

    it "sends out an email with the right subject" do
      subject = "Your I Heart Psychics call with #{psychic.full_name}"
      expect(email.subject).to include(subject)
    end

    it "sends out the duration of the call" do
      body = "You just finished a 2 minutes talk with #{psychic.full_name}."
      expect(email.body.encoded).to include(body)
    end

    context "when client has minutes left" do
      it "tells how much minutes are left in client's balance" do
        body = "You have a remaining balance of 10 minutes in your account."
        expect(email.body.encoded).to include(body)
      end
    end

    context "when client has no minutes left" do
      before { client.minutes = 0 }
      it "informs the client that he's out of minutes" do
        body = "Your account is out of minutes."
        expect(email.body.encoded).to include(body)
      end

      it "shows link to add more minutes" do
        body = "To add more minutes, please visit #{add_minutes_client_url}"
        expect(email.body.encoded).to include(body)
      end

      it "adds a click here link in HTML" do
        body = "Please <a href=\"#{add_minutes_client_url}\">click here</a>"
        expect(email.body.encoded).to include(body)
      end
    end
  end

  context "#psychic_call_statistics" do
    let(:email) { ClientCallMailer.psychic_call_statistics(client_call) }

    it "sends out the email to the client" do
      expect(email.to).to include(psychic.email)
    end

    it "sends out an email with the right subject" do
      subject = "Your I Heart Psychics call with #{client.full_name}"
      expect(email.subject).to include(subject)
    end

    it "sends out the duration of the call" do
      body = "You just finished a 2 minutes talk with #{client.full_name}."
      expect(email.body.encoded).to include(body)
    end
  end
end
