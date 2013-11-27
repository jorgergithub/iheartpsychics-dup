require "spec_helper"

describe PsychicsController do
  describe "GET search" do
    before {
      get :search, params
    }

    context "with no search" do
      let(:params) { {} }
      let!(:psychic1) { create(:psychic) }
      let!(:psychic2) { create(:psychic) }

      it "renders 200" do
        expect(response.status).to eql(200)
      end

      it "includes all psychics" do
        expect(assigns(:psychics)).to include(psychic1)
        expect(assigns(:psychics)).to include(psychic2)
      end
    end

    context "searching by specialty" do
      let(:params) { {specialty: "love_and_relationships"} }
      let!(:psychic1) { create(:psychic, specialties_love_and_relationships: true) }
      let!(:psychic2) { create(:psychic, specialties_love_and_relationships: false) }

      it "renders 200" do
        expect(response.status).to eql(200)
      end

      it "includes the psychic that has the specialy" do
        expect(assigns(:psychics)).to include(psychic1)
      end

      it "excludes the psychic that doesn't have the specialy" do
        expect(assigns(:psychics)).to_not include(psychic2)
      end
    end

    context "searching by tool" do
      let(:params) { {tool: "numerology"} }
      let!(:psychic1) { create(:psychic, tools_numerology: true) }
      let!(:psychic2) { create(:psychic, tools_numerology: false) }

      it "renders 200" do
        expect(response.status).to eql(200)
      end

      it "includes the psychic that has the tool" do
        expect(assigns(:psychics)).to include(psychic1)
      end

      it "excludes the psychic that doesn't have the tool" do
        expect(assigns(:psychics)).to_not include(psychic2)
      end
    end

    context "searching by available" do
      let(:params) { {status: "available"} }
      let!(:psychic1) { create(:psychic) }
      let!(:psychic2) { create(:psychic) }

      before {
        psychic1.available!
      }

      it "renders 200" do
        expect(response.status).to eql(200)
      end

      it "includes the available psychic" do
        expect(assigns(:psychics)).to include(psychic1)
      end

      it "excludes the unavailable psychic" do
        expect(assigns(:psychics)).to_not include(psychic2)
      end
    end
  end
end
