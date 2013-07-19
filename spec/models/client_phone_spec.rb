require "spec_helper"

describe ClientPhone do
  describe "#formatted_number" do
    let(:phone) { ClientPhone.new(number: "+17863295532")}
    it "returns the formatted phone number" do
      expect(phone.formatted_number).to eql("+1-786-329-5532")
    end
  end

  describe "saving a number" do
    let(:client) { FactoryGirl.create(:client) }
    it "removes formatting" do
      phone = client.phones.create(number: "+1-305-450-2995")
      expect(phone.number).to eql("+13054502995")
    end

    it "inserts +1 if needed" do
      phone = client.phones.create(number: "305-450-2995")
      expect(phone.number).to eql("+13054502995")
    end
  end
end
