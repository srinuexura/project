class AddDuration < ActiveRecord::Migration
  def change
    add_column :spree_products, :duration, :integer
  end
end
