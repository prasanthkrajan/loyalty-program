FactoryBot.define do

  factory :merchant_one, class: Merchant do
    full_name             { 'MyPhone'  }
    nature_of_business    { 'Smartphones' }
  end

  factory :merchant_two, class: Merchant do
    full_name             { 'MyComputer'  }
    nature_of_business    { 'Computers' }
  end
end
