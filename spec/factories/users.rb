FactoryGirl.define do

  factory :user, class: User do
    home_currency   { 'SGD' }
    date_of_birth   { Date.today }
    created_at      { Date.today - 1.week }
    after :create do |user|
      create_list :user_merchant_transaction, 15, user: user
      create_list :points_log, 30, points_earned: 1000, user: user
    end
  end

  factory :standard_tier_user, parent: :user do
    email           { Faker::Internet.email }
    full_name       { Faker::Name.name }
    loyalty_tier    { 'standard' }
  end

  factory :gold_tier_user, parent: :user do
    email           { Faker::Internet.email }
    full_name       { Faker::Name.name }
    loyalty_tier { 'gold' }
  end

  factory :platinum_tier_user, parent: :user do
    email           { Faker::Internet.email }
    full_name       { Faker::Name.name }
    loyalty_tier { 'platinum' }
  end
end
