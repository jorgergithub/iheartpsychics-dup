require 'spec_helper'

describe ClientsController do
  let(:user) { create(:user, create_as: 'client') }
  let(:client) { user.client }

  before {
    client.update_attributes(minutes: 50)
    user.confirm!
    sign_in user
  }

  describe "GET show" do
    context "when user has minutes" do
      before {
        get :show
      }

      it "shows the dashboard" do
        expect(response).to be_ok
      end
    end

    context "when user is out of minutes" do
      before {
        client.update_attributes(minutes: 0)
        get :show
      }

      it "redirects to new order" do
        expect(response).to redirect_to(:new_order)
      end
    end

    context "when a psychic the user had a call with was deleted" do
      render_views
      let!(:psychic) { create(:psychic) }
      let!(:call) { create(:processed_call, client: client, psychic: psychic) }

      before {
        psychic.destroy
        get :show
      }

      it "renders show template" do
        expect(response).to render_template("show")
      end
    end
  end
end
