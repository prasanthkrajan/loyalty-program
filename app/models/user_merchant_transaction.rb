class UserMerchantTransaction < ApplicationRecord
  belongs_to :merchant
  belongs_to :user

  class << self
    def first_transaction
      order('created_at ASC').first
    end
  end
end
