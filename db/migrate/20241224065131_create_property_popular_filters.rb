class CreatePropertyPopularFilters < ActiveRecord::Migration[8.0]
  def change
    create_table :property_popular_filters do |t|
      t.references :property, null: false, foreign_key: true
      t.references :popular_filter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
