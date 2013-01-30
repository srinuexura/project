class AddMapZoomColToActivities < ActiveRecord::Migration
  def change
    add_column :spree_products, :zoom_level, :integer
  end
end
