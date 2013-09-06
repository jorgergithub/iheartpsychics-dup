require "spec_helper"

describe Review do
  it { should belong_to :client }
  it { should belong_to :psychic }

  describe "validations" do
    it { should validate_presence_of(:client) }
    it { should validate_presence_of(:psychic) }
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:text) }
  end
end
