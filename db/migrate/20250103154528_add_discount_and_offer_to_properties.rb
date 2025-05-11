class AddDiscountAndOfferToProperties < ActiveRecord::Migration[8.0]
  def change
    add_column :properties, :discount_text, :string
    add_column :properties, :offer_text, :string
  end
end
