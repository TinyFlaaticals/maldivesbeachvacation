class Hotel < ApplicationRecord
  has_many_attached :images

  validates :name, presence: true

  has_rich_text :overview
end
