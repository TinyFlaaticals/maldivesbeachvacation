class RoomCategory < ApplicationRecord
  belongs_to :property

  validates :name, presence: true
  validates :normal_price, presence: true

  before_save :set_current_price

  private

  def set_current_price
    self.current_price = discounted_price || normal_price
  end
end
