class CreatePopularFilters < ActiveRecord::Migration[8.0]
  def change
    create_table :popular_filters do |t|
      t.string :name

      t.timestamps
    end
  end
end
