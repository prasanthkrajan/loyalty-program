require 'rails_helper'


describe API::V1::Rewards do
  describe 'POST /api/rewards' do
    context 'when user has points' do
      it 'allows user to claim reward' do
      end

      it 'does not allow the same type of reward claim more than once' do
      end
    end

    context 'when user does not have enough points' do
      it 'does not allow user to claim rewards' do
      end
    end
  end
end