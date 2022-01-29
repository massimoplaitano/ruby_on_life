class Game < ApplicationRecord
  MIN_SIZE = 3
  MAX_SIZE = 100

  belongs_to :user

  validates_presence_of :code, :width, :height, :grid_body
  validates_numericality_of :width, :height, only_integer: true, greater_than_or_equal_to: MIN_SIZE, less_than_or_equal_to: MAX_SIZE
  validates_numericality_of :generation, only_integer: true, greater_than_or_equal_to: 1

  before_validation :generate_code

  scope :only_public, -> { where(public: true) }
  scope :by_user, ->(user) { where(user: user) }
  scope :latest, ->(num = 5) { order(created_at: :desc).limit(num) }

  def generate_code
    self.code ||= SecureRandom.base58(6)
  end

  def to_param
    code
  end

  def grid
    @grid ||= Utils.grid_from_game(self)
  end
end
