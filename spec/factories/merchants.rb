FactoryGirl.define do
  factory :merchant, class: Merchant do
    email                 { 'merchant@email.com' }
    full_name             { 'MyPhoneX'  }
    nature_of_business    { 'Smartphones' }
  end
end
