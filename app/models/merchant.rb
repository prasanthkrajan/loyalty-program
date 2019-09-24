class Merchant < ApplicationRecord
  has_many :user_transactions, foreign_key: "merchant_id", class_name: 'UserMerchantTransaction'
  def authentication_token
    AuthenticationTokenGenerator.encode(self.email)
  end
end
