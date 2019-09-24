FactoryGirl.define do

  factory :user_merchant_transaction, class: UserMerchantTransaction do
    currency  { 'SGD' }
    amount    { 500 }
    created_at { Date.today - 63.days}
    merchant
  end
end
