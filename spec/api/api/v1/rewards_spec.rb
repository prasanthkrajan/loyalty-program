require 'rails_helper'


describe API::V1::Rewards do

  let!(:gold_tier_user)     { create(:gold_tier_user) }
  let!(:standard_tier_user) { create(:standard_tier_user) }
  let!(:user_rewards_count) { gold_tier_user.rewards.length }

  describe 'POST /api/rewards' do

    context 'when it is user birthday month' do
      it 'allows user to get a free coffee' do
      end

      it 'does not allow user to get more than one coffee under birthday reward type claim for that calendar year' do
      end
    end

    context 'when user has accumulated 100 points in one calendar month' do
      it 'allows user to get free coffee' do
      end

      it 'does not allow user to claim more than one free coffee under points reward type claim' do
      end

      it 'allows user to one more coffee under points claim reward type if previous coffee claim is under birthday month' do
      end
    end

    context 'when user has 10 or more transactions that have an amount > $100' do
      it 'allows user to claim cash rebate award' do
      end

      it 'does not allow to claim more than one cash rebate award' do
      end
    end

    context 'when new user has spending > $1000 within 60 days of their first transaction' do
      it 'allows user to claim movie ticket' do
      end

      it 'does not allow user to claim more than one movie ticket' do
      end
    end
=begin
    context 'when user has points' do
      it 'allows user to claim free coffee if accumulated 100 points in one calendar month' do
        contact_rewards_endpoint('Free Coffee','points', gold_tier_user)
        expect(response).to be_success
        expect(gold_tier_user.rewards.length).to eq(user_rewards_count + 1)
      end

      it 'allows reward claim for birthday month' do
        contact_rewards_endpoint('Free Coffee','birthday', gold_tier_user)
        expect(response).to be_success
        expect(gold_tier_user.rewards.pluck(:reward_type)).to eq(['points','birthday'])
      end

      it 'allows cash rebate claim if have 10 or more transactions that have an amount > $100' do
      end

      it 'allows movie ticket claim to new users when their spending is > $1000 within 60 days of their first transaction'

      it 'does not allow the same type of reward claim more than once' do
        contact_rewards_endpoint('Free Coffee','points', gold_tier_user)
        expect(response).not_to be_success
      end
    end

    context 'when user does not have enough points' do
      it 'does not allow user to claim points based rewards' do
        contact_rewards_endpoint('Free Coffee','points', standard_tier_user)
        expect(response).not_to be_success
      end

      it 'allows user to claim free coffee for birthday month' do
        contact_rewards_endpoint('Free Coffee','birthday', standard_tier_user)
        expect(response).to be_success
      end
    end
=end
  end

  private

  def contact_rewards_endpoint(reward_name, reward_type, user)
    post "/api/rewards", params: {name: reward_name, reward_type: reward_type}, headers: {'Authorization' => "#{user.authentication_token}"}
  end
end