class AddFieldsToAdminConfig < ActiveRecord::Migration[8.0]
  def change
    add_column :admin_configs, :contact_phone, :string
    add_column :admin_configs, :office_hours_weekday, :string
    add_column :admin_configs, :office_hours_saturday, :string
    add_column :admin_configs, :hero_title, :string
    add_column :admin_configs, :hero_subtitle, :string
  end
end
