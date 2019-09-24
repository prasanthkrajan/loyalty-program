FactoryBot.define do

  factory :transaction_one, class: UserMerchantTransaction do
    currency  { 'SGD' }
    amount    { 150 }
    created_at { Date.today + 1.week}
    merchant_one
    gold_tier_user
  end

  factory :transaction_two, class: UserMerchantTransaction do
    currency  { 'SGD' }
    amount    { 150 }
    created_at { Date.today + 1.week}
    merchant_two
    gold_tier_user
  end

  factory :transaction_three, class: UserMerchantTransaction do
    currency  { 'SGD' }
    amount    { 170 }
    created_at { Date.today + 1.week}
    merchant_one
    gold_tier_user
  end

  factory :transaction_four, class: UserMerchantTransaction do
    currency  { 'SGD' }
    amount    { 200 }
    created_at { Date.today + 1.week}
    merchant_one
    gold_tier_user
  end

  factory :transaction_five, class: UserMerchantTransaction do
    currency  { 'SGD' }
    amount    { 200 }
    created_at { Date.today + 1.week}
    merchant_one
    gold_tier_user
  end

  factory :transaction_six, class: UserMerchantTransaction do
    currency  { 'SGD' }
    amount    { 300 }
    created_at { Date.today + 1.week}
    merchant_two
    gold_tier_user
  end

  factory :transaction_seven, class: UserMerchantTransaction do
    currency  { 'SGD' }
    amount    { 300 }
    created_at { Date.today + 1.week}
    merchant_one
    gold_tier_user
  end

  factory :transaction_eight, class: UserMerchantTransaction do
    currency  { 'SGD' }
    amount    { 200 }
    created_at { Date.today + 1.week}
    merchant_one
    gold_tier_user
  end

  factory :transaction_nine, class: UserMerchantTransaction do
    currency  { 'SGD' }
    amount    { 500 }
    created_at { Date.today + 1.week}
    merchant_one
    gold_tier_user
  end

  factory :transaction_ten, class: UserMerchantTransaction do
    currency  { 'SGD' }
    amount    { 400 }
    created_at { Date.today + 1.week}
    merchant_one
    gold_tier_user
  end

  factory :transaction_eleven, class: UserMerchantTransaction do
    currency  { 'SGD' }
    amount    { 400 }
    created_at { Date.today + 1.week}
    merchant_two
    gold_tier_user
  end
end
