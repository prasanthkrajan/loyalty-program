class LoyaltyPoints::Issuer
  include ActiveModel::Model

  POINTS_CONVERSION = 0.1

  validate :end_user_present

  def initialize(end_user_id, merchant)
    @end_user_id = end_user_id
    @merchant = merchant
  end

  def run
    if valid?
      issue_points
    end
    errors.empty?
  rescue => e
    errors.add(:base, e.message)
    errors.empty?
  end

  private

  def issue_points
    PointsLog.create!(points_earned: points_earned,
                      issued_by: merchant.id,
                      user_id: end_user.id,
                      valid_until: Date.today + 1.year)
  end

  def end_user_present
    end_user.present?
  end

  def end_user
    User.find(end_user_id.to_i) rescue nil
  end

  def points_earned
    (transaction_amount_with_merchant * POINTS_CONVERSION).to_i
  end

  def transaction_amount_with_merchant
    end_user.merchant_transactions.where(merchant_id: merchant_id).sum(:amount).to_i
  end
end