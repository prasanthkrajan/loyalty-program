FactoryGirl.define do

  factory :merchant, class: Merchant do
    full_name             { 'MyPhoneX'  }
    nature_of_business    { 'Smartphones' }
  end
end
