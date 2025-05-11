class AddTokenToBookings < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :token, :string
    add_index :bookings, :token, unique: true
  end
end
