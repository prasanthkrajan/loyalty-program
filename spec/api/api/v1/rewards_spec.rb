require 'rails_helper'


describe API::V1::Rewards do

  let!(:gold_tier_user)     { create(:gold_tier_user) }
  let!(:standard_tier_user) { create(:standard_tier_user) }
  let!(:user_rewards_count) { gold_tier_user.rewards.length }

  describe 'POST /api/rewards' do
    context 'when user has points' do
      it 'allows user to claim reward' do
        contact_rewards_endpoint('points', gold_tier_user)
        expect(response).to be_success
        expect(gold_tier_user.rewards.length).to eq(user_rewards_count + 1)
      end

      it 'does not allow the same type of reward claim more than once' do
        contact_rewards_endpoint('points', gold_tier_user)
        expect(response).not_to be_success
      end

      it 'allows same reward claim with a different claim type' do
        contact_rewards_endpoint('birthday', gold_tier_user)
        expect(response).to be_success
        expect(gold_tier_user.rewards.pluck(:reward_type)).to eq(['points','birthday'])
      end

      it 'allows user without points to claim birthday reward' do
        contact_rewards_endpoint('birthday', standard_tier_user)
        expect(response).to be_success
        expect(standard_tier_user.rewards.length).to eq(1)
      end
    end

    context 'when user does not have enough points' do
      it 'does not allow user to claim rewards' do
        contact_rewards_endpoint('points', standard_tier_user)
        expect(response).not_to be_success
      end
    end
  end

  private

  def contact_rewards_endpoint(reward_type)
    post "/api/rewards", params: {name: 'Free Coffee', reward_type: reward_type}, headers: {'Authorization' => "#{user.authentication_token}"}
  end
end