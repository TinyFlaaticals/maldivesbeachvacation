class CreateRoomCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :room_categories do |t|
      t.string :name
      t.references :property, null: false, foreign_key: true
      t.decimal :normal_price, precision: 10, scale: 2
      t.decimal :discounted_price, precision: 10, scale: 2
      t.integer :discount_percent
      t.decimal :current_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
