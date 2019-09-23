FactoryGirl.define do

  factory :standard_tier_user, class: User do
    email           { Faker::Internet.email }
    full_name       { Faker::Name.name }
    loyalty_tier    { 'standard' }
    home_currency   { 'SGD' }
    date_of_birth   { Date.today }
  end

  factory :gold_tier_user, parent: :user do
    loyalty_tier { 'gold' }
  end

  factory :platinum_tier_user, parent: :user do
    loyalty_tier { 'platinum' }
  end
end
