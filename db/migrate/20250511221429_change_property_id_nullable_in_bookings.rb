class ChangePropertyIdNullableInBookings < ActiveRecord::Migration[8.0]
  def change
    change_column_null :bookings, :property_id, true
  end
end
