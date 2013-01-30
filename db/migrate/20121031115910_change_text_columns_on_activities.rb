class ChangeTextColumnsOnActivities < ActiveRecord::Migration
  def change
    change_column :spree_products, :overview, :text
    change_column :spree_products, :highlights, :text
    change_column :spree_products, :features, :text
    change_column :spree_products, :exclusions, :text
    change_column :spree_products, :cancellation_policy, :text
    change_column :spree_products, :description, :text
  end
end
