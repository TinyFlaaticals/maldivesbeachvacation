class CreatePropertyActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :property_activities do |t|
      t.references :property, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
