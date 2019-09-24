FactoryGirl.define do

  factory :user, class: User do
    email           { Faker::Internet.email }
    full_name       { Faker::Name.name }
    home_currency   { 'SGD' }
    date_of_birth   { Date.today }
    created_at      { Date.today - 1.week }
  end

  factory :standard_tier_user, class: User do
    loyalty_tier    { 'standard' }
  end

  factory :gold_tier_user, parent: :user do
    loyalty_tier { 'gold' }
  end

  factory :platinum_tier_user, parent: :user do
    loyalty_tier { 'platinum' }
  end
end
