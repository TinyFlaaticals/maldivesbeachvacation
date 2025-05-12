class Story < ApplicationRecord
  validates :title, presence: true

  has_one_attached :image
  has_rich_text :content

  has_many :story_tags, dependent: :destroy
  has_many :tags, through: :story_tags

  # Default scope to fetch stories in reverse chronological order
  default_scope { order(created_at: :desc) }

  # Scope for published stories
  scope :published, -> { where(published: true) }

  # Returns stories that should be visible based on publish date
  scope :published_and_visible, -> {
    published.where("publish_date IS NULL OR publish_date <= ?", Time.current)
  }

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
end
