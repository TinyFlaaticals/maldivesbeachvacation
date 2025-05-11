class AdminConfig < ApplicationRecord
  has_rich_text :about_us

  def self.instance
    AdminConfig.first_or_create
  end
end
