class AddGmapsToActivities < ActiveRecord::Migration
  def change
    add_column :spree_products, :longitude, :float
    add_column :spree_products, :latitude,  :float
  end
end
