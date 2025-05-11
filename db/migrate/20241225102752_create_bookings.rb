class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.references :property, null: false, foreign_key: true
      t.string :full_name
      t.string :email
      t.string :phone_number
      t.string :room_type
      t.string :meal_plan
      t.integer :rooms
      t.date :check_in
      t.date :check_out
      t.integer :adults
      t.integer :children
      t.string :additional_service_request

      t.timestamps
    end
  end
end
