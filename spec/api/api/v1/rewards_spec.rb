require 'rails_helper'

describe API::V1::Rewards do

  let!(:gold_tier_user_one)     { create(:gold_tier_user) }
  let!(:gold_tier_user_two)     { create(:gold_tier_user) }
  let!(:standard_tier_user)     { create(:standard_tier_user) }
  let!(:reward_one)             { create(:reward, user_id: gold_tier_user_one.id,
                                                  name: 'Free Coffee',
                                                  reward_type: 'birthday'
                                )}
  let!(:reward_two)             { create(:reward, user_id: gold_tier_user_two.id,
                                                  name: 'Free Coffee',
                                                  reward_type: 'points'
                                )}
  let!(:reward_three)           { create(:reward, user_id: gold_tier_user_two.id,
                                                  name: 'Cash Rebate',
                                                  reward_type: 'points'
                                )}
  let!(:reward_four)            { create(:reward, user_id: gold_tier_user_two.id,
                                                  name: 'Movie Ticket',
                                                  reward_type: 'points'
                                )}


  describe 'POST /api/rewards' do

    context 'when it is user birthday month' do
      it 'allows user to get a free coffee' do
        contact_rewards_endpoint('Free Coffee','birthday', standard_tier_user)
        expect(response).to be_success
        expect(standard_tier_user.rewards.where(reward_type: 'birthday', name: 'Free Coffee').length).to eq(1)
      end

      it 'does not allow user to get more than one coffee under birthday reward type claim for that calendar year' do
        contact_rewards_endpoint('Free Coffee','birthday', gold_tier_user_one)
        expect(response).not_to be_success
        expect(gold_tier_user_one.rewards.where(reward_type: 'birthday', name: 'Free Coffee').length).to eq(1)
      end
    end

    context 'when user has accumulated 100 points in one calendar month' do
      it 'allows user to get free coffee' do
        contact_rewards_endpoint('Free Coffee','points', gold_tier_user_one)
        expect(response).to be_success
        expect(gold_tier_user_one.rewards.where(reward_type: 'points', name: 'Free Coffee').length).to eq(1)
      end

      it 'does not allow user to claim more than one free coffee under points reward type claim' do
        contact_rewards_endpoint('Free Coffee','points', gold_tier_user_two)
        expect(response).not_to be_success
        expect(gold_tier_user_two.rewards.where(reward_type: 'points', name: 'Free Coffee').length).to eq(1)
      end
    end

    context 'when user has 10 or more transactions that have an amount > $100' do
      it 'allows user to claim cash rebate award' do
        contact_rewards_endpoint('Cash Rebate','points', gold_tier_user_one)
        expect(response).to be_success
        expect(gold_tier_user_one.rewards.where(reward_type: 'points', name: 'Cash Rebate').length).to eq(1)
      end

      it 'does not allow to claim more than one cash rebate award' do
        contact_rewards_endpoint('Cash Rebate','points', gold_tier_user_two)
        expect(response).not_to be_success
        expect(gold_tier_user_two.rewards.where(reward_type: 'points', name: 'Cash Rebate').length).to eq(1)
      end
    end

    context 'when new user has spending > $1000 within 60 days of their first transaction' do
      it 'allows user to claim movie ticket' do
        contact_rewards_endpoint('Movie Ticket','points', gold_tier_user_one)
        expect(response).to be_success
        expect(gold_tier_user_one.rewards.where(reward_type: 'points', name: 'Movie Ticket').length).to eq(1)
      end

      it 'does not allow user to claim more than one movie ticket' do
        contact_rewards_endpoint('Movie Ticket','points', gold_tier_user_two)
        expect(response).not_to be_success
        expect(gold_tier_user_two.rewards.where(reward_type: 'points', name: 'Movie Ticket').length).to eq(1)
      end
    end

  end

  private

  def contact_rewards_endpoint(reward_name, reward_type, user)
    post "/api/rewards", params: {name: reward_name, reward_type: reward_type}, headers: {'Authorization' => "#{user.authentication_token}"}
  end
end