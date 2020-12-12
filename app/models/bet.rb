class Bet < ApplicationRecord
  belongs_to :roulette
  belongs_to :user

  validates :size, presence: true
  validates :size, numericality: {greater_than: 0}

  validate :size_smaller_or_equal_to_roulette_shares_available

  def size_smaller_or_equal_to_roulette_shares_available
    if size > roulette.shares_available
      errors.add(:size, "can't be greater than shares available: #{roulette.shares_available}")
    end
  end

  validate :size_smaller_or_equal_to_user_balance

  def size_smaller_or_equal_to_user_balance
    if size > user.balance
      errors.add(:size, "can't be greater than your balance: #{user.balance}")
    end
  end

  #after_create do
  #  if roulette.shares_available.zero?
  #    Roulette.create(shares_total: @roulette.shares_total)
  #  end
  #end

end
