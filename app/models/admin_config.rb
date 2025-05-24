class AdminConfig < ApplicationRecord
  has_rich_text :about_us

  has_one_attached :about_image
  has_one_attached :hero_image
  has_one_attached :middle_image

  validates :contact_email, format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }

  def self.instance
    AdminConfig.first_or_create
  end
end
