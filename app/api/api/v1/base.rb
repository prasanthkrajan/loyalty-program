module API::V1
  class Base < API::Base
    version 'v1', using: :header, vendor: 'whistler'

    format :json
    mount API::V1::Rewards
    mount API::V1::LoyaltyPoints
  end
end