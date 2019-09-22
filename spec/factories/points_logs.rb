FactoryGirl.define do

  factory :points_log_one, class: PointsLog do
    points_earned { 2000 }
    valid_until { Date.today + 1.year }
    gold_tier_user
    merchant_one
  end

  factory :points_log_two, class: PointsLog do
    points_earned { 3000 }
    valid_until { Date.today + 1.year }
    platinum_tier_user
    merchant_one
  end

  factory :points_log_three, class: PointsLog do
    points_earned { 3000 }
    valid_until { Date.today + 1.year }
    platinum_tier_user
    merchant_two
  end
end
