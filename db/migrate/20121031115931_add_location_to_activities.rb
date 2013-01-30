class AddLocationToActivities < ActiveRecord::Migration
  def change
    add_column :spree_products, :location, :string
  end
end
