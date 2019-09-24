class User < ApplicationRecord
  def authentication_token
    AuthenticationTokenGenerator.encode(self.email)
  end
end
