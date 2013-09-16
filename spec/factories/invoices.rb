# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invoice, :class => 'Invoices' do
    psychic_id 1
    minutes 1
    calls 1
    avg_minutes "9.99"
    total_minutes "9.99"
    total_bonus "9.99"
    tier_id 1
  end
end
