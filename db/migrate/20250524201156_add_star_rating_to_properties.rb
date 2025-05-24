class AddStarRatingToProperties < ActiveRecord::Migration[8.0]
  def change
    add_column :properties, :star_rating, :decimal, precision: 2, scale: 1, default: 4.5
  end
end
