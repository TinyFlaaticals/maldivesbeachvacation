class AddPublishingFieldsToStories < ActiveRecord::Migration[8.0]
  def change
    add_column :stories, :published, :boolean, default: true
    add_column :stories, :publish_date, :datetime
  end
end
