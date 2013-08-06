FactoryGirl.define do
  sequence :email do |n|
    "john#{n}@doe.com"
  end

  sequence :username do |n|
    "johndoe#{n}"
  end

  factory :user do
    first_name "John"
    last_name "Doe"
    email { generate(:email) }
    username { generate(:username) }
    password "testpass"
  end

  factory :client do
    association :user
    minutes 60
  end

  factory :psychic do
    association :user
  end

  factory :package do
    name "Minutes Package"
    minutes 10
    price "9.99"
  end

  factory :client_call do
    sid "CAc1ffa7a744d25480e5ee009dfd7b2fc4"
    association :client
    association :psychic
    date_created "Wed, 17 Jul 2013 23:50:32 +0000"
    date_updated "Wed, 17 Jul 2013 23:51:57 +0000"
    account_sid "AC4d5e48e4d4647262b5c4314e36e3d26e"
    to "+15186335473"
    from "+17863295532"
    phone_number_sid "PN9523396e26f2d67f4375b7c67599a191"
    status "completed"
    start_time "Wed, 17 Jul 2013 23:50:32 +0000"
    end_time "Wed, 17 Jul 2013 23:51:57 +0000"
    original_duration "85"
    price "-0.02000"
    price_unit "USD"
    direction "inbound"
    answered_by nil
    caller_name nil
    uri "/2010-04-01/Accounts/AC4d5e48e4d4647262b5c4314e36e3d26e/Calls/CAc1ffa7a744d25480e5ee009dfd7b2fc4.json"
    processed nil

    factory :processed_call do
      processed true
    end
  end

  factory :order do
    association :client
    total "9.99"
    status nil
  end

  factory :order_item do
    association :order
    association :package
    description "MyString"
    qty 1
    unit_price "9.99"
    total_price "9.99"
  end
end
