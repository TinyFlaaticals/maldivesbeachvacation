class Facility < ApplicationRecord
  has_many :property_facilities, dependent: :destroy
  has_many :properties, through: :property_facilities

  validates :name, presence: true, uniqueness: true
end
