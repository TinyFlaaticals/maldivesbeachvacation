class CreateProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :address
      t.string :tagline
      t.text :short_description
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.decimal :normal_price, precision: 10, scale: 2
      t.decimal :discounted_price, precision: 10, scale: 2
      t.integer :discount_percent
      t.decimal :current_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
