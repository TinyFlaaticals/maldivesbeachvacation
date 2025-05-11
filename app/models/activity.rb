class Activity < ApplicationRecord
  has_many :property_activities, dependent: :destroy
  has_many :properties, through: :property_activities

  validates :name, presence: true, uniqueness: true
end
