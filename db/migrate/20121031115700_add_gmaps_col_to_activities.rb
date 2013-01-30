class AddGmapsColToActivities < ActiveRecord::Migration
  def change
    add_column :spree_products, :gmaps, :boolean
  end
end
