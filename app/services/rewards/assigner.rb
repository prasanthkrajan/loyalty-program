class Rewards::Assigner
  include ActiveModel::Model

  attr_accessor :user, :errors, :reward
  attr_reader :params

  validate :free_coffee_conditions
  validate :cash_rebate_conditions
  validate :movie_ticket_conditions

  def initialize(user, params)
    @user = user
    @params = params
    @errors = ActiveModel::Errors.new(self)
    @reward = nil
  end

  def run
    if valid?
      assign_reward
    end
    errors.empty?
  rescue => e
    errors.add(:base, e.message)
    errors.empty?
  end

  private

  def assign_reward
    @reward = Reward.create!(user_id: user.id, name: params[:name], reward_type: params[:reward_type])
  end

  def free_coffee_conditions
    params[:name] == 'Free Coffee' ? check_free_coffee_conditions : true
  end

  def cash_rebate_conditions
    params[:name] == 'Cash Rebate' ? check_cash_rebate_conditions : true
  end

  def movie_ticket_conditions
    params[:name] == 'Movie Ticket' ? check_movie_ticket_conditions : true
  end

  def check_free_coffee_conditions
    errors.add(:base, 'Cannot claim free coffee') unless Rewards::Validations::FreeCoffee.new(user, params).pass?
  end

  def check_cash_rebate_conditions
    errors.add(:base, 'Cannot claim cash rebate') unless Rewards::Validations::CashRebate.new(user, params).pass?
  end

  def check_movie_ticket_conditions
    errors.add(:base, 'Cannot claim movie ticket') unless Rewards::Validations::MovieTicket.new(user, params).pass?
  end
end