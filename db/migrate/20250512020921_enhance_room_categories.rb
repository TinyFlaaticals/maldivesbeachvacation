class EnhanceRoomCategories < ActiveRecord::Migration[8.0]
  def change
    # Add descriptive fields
    add_column :room_categories, :short_description, :text
    add_column :room_categories, :full_description, :text

    # Room dimensions
    add_column :room_categories, :size_sqm, :string
    add_column :room_categories, :size_sqft, :string

    # Occupancy information
    add_column :room_categories, :max_adults, :integer, default: 2
    add_column :room_categories, :max_children, :integer, default: 0

    # Room configuration
    add_column :room_categories, :num_bedrooms, :integer, default: 1
    add_column :room_categories, :num_bathrooms, :integer, default: 1
    add_column :room_categories, :bed_configuration, :string

    # Key features
    add_column :room_categories, :has_pool, :boolean, default: false
    add_column :room_categories, :has_beach_access, :boolean, default: false
    add_column :room_categories, :has_ocean_view, :boolean, default: false

    # Serialized amenities (stored as JSON arrays)
    add_column :room_categories, :comfort_amenities, :text
    add_column :room_categories, :convenience_features, :text

    # Index for performance - only add if it doesn't exist
    unless index_exists?(:room_categories, :property_id)
      add_index :room_categories, :property_id
    end
  end
end
