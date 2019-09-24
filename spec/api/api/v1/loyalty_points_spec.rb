require 'rails_helper'

describe API::V1::LoyaltyPoints do
  let!(:merchant)            { create(:merchant) }
  let!(:standard_tier_user)  { create(:standard_tier_user) }
  let!(:transaction_amount)  { standard_tier_user.merchant_transactions.sum(:amount).to_i }
  let!(:current_points)      { standard_tier_user.points.sum(:points_earned).to_i }

  describe 'POST /api/loyalty_points' do
    it 'allows merchant to issue loyalty point to end user, auto calculated based on users transaction amount with merchant' do
      contact_loyalty_points_endpoint(merchant, standard_tier_user.id)
      expect(response).to be_success
      expect(user.points.sum(:points_earned).to_i).to eq((current_points + (transaction_amount * 0.1)).to_i)
    end
  end

  private

  def contact_loyalty_points_endpoint(merchant, end_user_id)
    post "/api/loyalty_points", params: {end_user_id: end_user_id}, headers: {'Authorization' => "#{merchant.authentication_token}"}
  end
end