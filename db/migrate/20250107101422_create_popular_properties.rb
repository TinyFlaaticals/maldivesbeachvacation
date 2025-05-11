class CreatePopularProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :popular_properties do |t|
      t.references :property, null: false, foreign_key: true
      t.integer :sort_order, default: 0

      t.timestamps
    end
  end
end
