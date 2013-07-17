require "spec_helper"

describe ClientPhone do
  describe "#formatted_number" do
    let(:phone) { ClientPhone.new(number: "+17863295532")}
    it "returns the formatted phone number" do
      expect(phone.formatted_number).to eql("+1-786-329-5532")
    end
  end
end
