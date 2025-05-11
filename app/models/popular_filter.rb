class PopularFilter < ApplicationRecord
  has_many :property_popular_filters, dependent: :destroy
  has_many :properties, through: :property_popular_filters

  validates :name, presence: true, uniqueness: true
end
