class CreateAdminConfigs < ActiveRecord::Migration[8.0]
  def change
    create_table :admin_configs do |t|
      t.string :contact_email

      t.timestamps
    end
  end
end
