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
    errors.add(:base, 'Cannot claim free coffee') unless (user_birthday_month || accumulated_100_points_in_a_calendar_month) && no_previous_similar_redemption
  end

  def check_cash_rebate_conditions
    errors.add(:base, 'Cannot claim cash rebate') unless user_spent_more_than_100_in_more_than_10_transactions && no_previous_similar_redemption
  end

  def check_movie_ticket_conditions
    errors.add(:base, 'Cannot claim movie ticket') unless user_spent_1000_in_60_days && no_previous_similar_redemption
  end

  def user_birthday_month
    user.date_of_birth.mon == Date.today.mon
  end

  def accumulated_100_points_in_a_calendar_month
    user.points.where(created_at: Date.today.beginning_of_month..Date.today.end_of_month).sum(:points_earned).to_i >= 100
  end

  def no_previous_similar_redemption
    user.rewards.where(name: params[:name], reward_type: params[:reward_type]).empty?
  end

  def user_spent_more_than_100_in_more_than_10_transactions
    user.merchant_transactions.collect{ |s| s.amount >= 100 }.length >= 10
  end

  def user_spent_1000_in_60_days
    return false unless first_transaction.present?
    user.merchant_transactions.where("created_at >= ?", first_transaction.created_at).sum(:amount).to_i >= 1000
  end

  def first_transaction
    user.merchant_transactions.first_transaction
  end
end