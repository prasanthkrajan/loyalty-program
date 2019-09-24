class User < ApplicationRecord
  has_many :rewards
  def authentication_token
    AuthenticationTokenGenerator.encode(self.email)
  end
end
