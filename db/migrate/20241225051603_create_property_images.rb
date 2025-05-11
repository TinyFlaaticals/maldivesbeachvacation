class CreatePropertyImages < ActiveRecord::Migration[8.0]
  def change
    create_table :property_images do |t|
      t.references :property, null: false, foreign_key: true
      t.integer :sort_order, null: false, default: 0

      t.timestamps
    end
  end
end
