class Story < ApplicationRecord
  validates :title, presence: true

  has_one_attached :image
  has_rich_text :content
end
