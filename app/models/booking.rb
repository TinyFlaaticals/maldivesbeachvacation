class Booking < ApplicationRecord
  belongs_to :property, optional: true

  validates :full_name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :room_type, presence: true
  validates :meal_plan, presence: true
  validates :rooms, presence: true
  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :adults, presence: true
  validates :children, presence: true

  before_create :generate_token

  private
  
  def generate_token
    self.token = SecureRandom.uuid
  end
end
