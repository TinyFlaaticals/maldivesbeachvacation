class RemoveOverviewFromHotels < ActiveRecord::Migration[8.0]
  def change
    remove_column :hotels, :overview, :string
  end
end
