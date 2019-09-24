class User < ApplicationRecord
  has_many :rewards
  has_many :points, foreign_key: "user_id", class_name: "PointsLog"
  has_many :merchant_transactions, foreign_key: "user_id", class_name: 'UserMerchantTransaction'

  def authentication_token
    AuthenticationTokenGenerator.encode(self.email)
  end
end
