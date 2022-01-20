class Game < ApplicationRecord
  MIN_SIZE = 3
  MAX_SIZE = 100

  belongs_to :user

  validates_presence_of :code, :width, :height, :content
  validates_numericality_of :width, :height, only_integer: true, greater_than_or_equal_to: MIN_SIZE, less_than_or_equal_to: MAX_SIZE

  before_validation :generate_code

  def generate_code
    self.code ||= SecureRandom.base58(6)
  end
end
