class AddAddressesToProducts < ActiveRecord::Migration
  def change
    add_column    :spree_products, :street_address, :string
    add_column    :spree_products, :city,           :string
    rename_column :spree_products, :location,       :state
  end
end
