class Roulette < ApplicationRecord

  has_many :bets
  belongs_to :user, required: false, counter_cache: true # winner

  scope :active, -> { where("shares_available > ?", 0) }
  scope :finished, -> { where(shares_available: 0) }

  validates :shares_total, presence: true

  def to_s
    shares_total
  end

  after_create do 
    update_column :shares_available, shares_total
  end
  
  def update_available_shares
    update_column :shares_taken, bets.map(&:size).sum
    update_column :shares_available, (shares_total - shares_taken)
    update_column :percent_left, (shares_taken.to_f/shares_total.to_f*100)
  end

  def finished?
    shares_available.zero?
  end

  def active?
    shares_available.nonzero?
  end

end
