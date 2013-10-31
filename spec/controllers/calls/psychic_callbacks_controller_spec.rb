require "spec_helper"

describe Calls::PsychicCallbacksController do
  describe "POST create" do
    let(:callback) { create(:callback) }

    before {
      post :create, callback_id: callback.id
    }

    it "renders 200" do
      expect(response.status).to eql(200)
    end

    it "greets the psychic" do
      expect(response.body).to match(/Hello #{callback.psychic.first_name}/)
    end
  end
end
