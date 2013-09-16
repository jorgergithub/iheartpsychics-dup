require "spec_helper"

describe Invoice do
  describe ".create_for" do
    let(:psychic) { create(:psychic) }

    before do
      Tier.create(from: 0, to: 999, name: "Bronze", percent: 14)
      Tier.create(from: 1000, to: 1199, name: "Silver", percent: 19)
      Tier.create(from: 1200, to: 1599, name: "Gold", percent: 19.5)
      Tier.create(from: 1600, to: 1999, name: "Platinum", percent: 20)
      Tier.create(from: 2000, to: 999999, name: "Diamond", percent: 21)
    end

    context "when psychic has between 1000 and 1199 minutes" do
      let!(:call1) { create(:call, psychic: psychic, original_duration: "30000", started_at: "2013-01-01 10:00", cost: 4.50 * 500) } # 2250
      let!(:call2) { create(:call, psychic: psychic, original_duration: "27600", started_at: "2013-01-02 11:00", cost: 4.50 * 460) } # 2070
      let!(:call3) { create(:call, psychic: psychic, original_duration: "10800", started_at: "2013-01-02 11:00", cost: 4.50 * 180) } #  810 == 5130

      let(:invoice) { Invoice.first }

      before {
        Invoice.create_for("2013-01-01 00:00", "2013-01-08 00:00")
      }

      it "creates one invoice" do
        expect(Invoice.count).to eql(1)
      end

      it "sets the number of minutes" do
        expect(invoice.total_minutes).to eql(1140)
      end

      it "sets the correct tier" do
        expect(invoice.tier).to eql(Tier.where(name: "Silver").take)
      end

      it "sets the minutes payout" do
        expect(invoice.minutes_payout.to_f).to eql(974.7)
      end

      it "sets the total to the minutes total" do
        expect(invoice.total.to_f).to eql(974.7)
      end

      it "sets the average minutes per call" do
        expect(invoice.avg_minutes.to_f).to eql(380.0)
      end

      context "when there are calls placed between 12AM and 8AM" do
        let!(:call1) { create(:call, psychic: psychic, original_duration: "30000", started_at: "2013-01-01 10:00", cost: 4.50 * 500) } # 2250
        let!(:call2) { create(:call, psychic: psychic, original_duration: "27600", started_at: "2013-01-02 00:30", cost: 4.50 * 460) } # 2070
        let!(:call3) { create(:call, psychic: psychic, original_duration: "10800", started_at: "2013-01-04 00:30", cost: 4.50 * 180) } #  810 == 5130

        it "has the same calls" do
          expect(invoice.calls.count).to eql(3)
        end

        it "has the same minutes payout" do
          expect(invoice.minutes_payout.to_f).to eql(974.7)
        end

        it "has some bonus payout" do
          expect(invoice.bonus_payout.to_f).to eql(44.8)
        end

        it "has some bonus minutes" do
          expect(invoice.bonus_minutes).to eql(640)
        end

        it "sets the total with a sum of minutes and bonuses" do
          expect(invoice.total.to_f).to eql(1019.5)
        end
      end
    end

    context "when psychic has up to 1000 minutes" do
      let!(:call1) { create(:call, psychic: psychic, original_duration: "30000", started_at: "2013-01-01 10:00", cost: 4.50 * 500) }
      let!(:call2) { create(:call, psychic: psychic, original_duration: "29940", started_at: "2013-01-02 11:00", cost: 4.50 * 499) }
      let(:invoice) { Invoice.first }

      before {
        Invoice.create_for("2013-01-01 00:00", "2013-01-08 00:00")
      }

      it "creates one invoice" do
        expect(Invoice.count).to eql(1)
      end

      it "sets the number of minutes" do
        expect(invoice.total_minutes).to eql(999)
      end

      it "sets the correct tier" do
        expect(invoice.tier).to eql(Tier.where(name: "Bronze").take)
      end

      it "sets the minutes payout" do
        expect(invoice.minutes_payout.to_f).to eql(629.37)
      end

      it "sets the total to the minutes total" do
        expect(invoice.total.to_f).to eql(629.37)
      end

      it "sets the average minutes per call" do
        expect(invoice.avg_minutes.to_f).to eql(499.5)
      end

      context "when there are calls placed between 12AM and 8AM" do
        let!(:call1) { create(:call, psychic: psychic, original_duration: "30000", started_at: "2013-01-01 10:00", cost: 4.50 * 500) }
        let!(:call2) { create(:call, psychic: psychic, original_duration: "29940", started_at: "2013-01-02 05:00", cost: 4.50 * 499) }

        it "has the same minutes payout" do
          expect(invoice.minutes_payout.to_f).to eql(629.37)
        end

        it "has some bonus payout" do
          expect(invoice.bonus_payout.to_f).to eql(34.93)
        end

        it "has some bonus minutes" do
          expect(invoice.bonus_minutes).to eql(499)
        end

        it "sets the total with a sum of minutes and bonuses" do
          expect(invoice.total.to_f).to eql(664.3)
        end
      end
    end
  end
end
