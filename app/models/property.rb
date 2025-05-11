class Property < ApplicationRecord
  has_rich_text :overview

  has_many :property_images, dependent: :destroy
  accepts_nested_attributes_for :property_images, reject_if: :all_blank, allow_destroy: true
  validates :property_images, length: { maximum: 10, message: "cannot have more than 10 images" }

  has_many :property_facilities, dependent: :destroy
  has_many :facilities, through: :property_facilities

  has_many :property_activities, dependent: :destroy
  has_many :activities, through: :property_activities

  has_many :property_popular_filters, dependent: :destroy
  has_many :popular_filters, through: :property_popular_filters

  has_many :bookings, dependent: :nullify

  has_many :room_categories, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :normal_price, presence: true
  validates :discounted_price, presence: true
  validates :discount_percent, presence: true


  extend FriendlyId
  friendly_id :name, use: :slugged

  before_save :set_current_price

  scope :with_offer, -> { where.not(offer_text: nil) }

  scope :with_discount, -> { where.not(discount_text: nil) }

  scope :by_facilities, ->(facility_ids) {
    facility_ids = Array(facility_ids)
    joins(:facilities)
      .group("properties.id")
      .having("COUNT(DISTINCT facilities.id) = ?", facility_ids.size)
      .where(facilities: { id: facility_ids })
  }

  scope :by_activities, ->(activity_ids) {
    activity_ids = Array(activity_ids)
    joins(:activities)
      .group("properties.id")
      .having("COUNT(DISTINCT activities.id) = ?", activity_ids.size)
      .where(activities: { id: activity_ids })
  }

  scope :by_popular_filters, ->(filter_ids) {
    filter_ids = Array(filter_ids)
    joins(:popular_filters)
      .group("properties.id")
      .having("COUNT(DISTINCT popular_filters.id) = ?", filter_ids.size)
      .where(popular_filters: { id: filter_ids })
  }

  scope :by_price_range, ->(min, max) {
    if min.present? && max.present?
      where(current_price: min.to_f..max.to_f)
    elsif min.present?
      where("current_price >= ?", min.to_f)
    elsif max.present?
      where("current_price <= ?", max.to_f)
    end
  }

  private

  def set_current_price
    self.current_price = discounted_price || normal_price
  end
end
