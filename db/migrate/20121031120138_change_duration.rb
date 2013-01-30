class ChangeDuration < ActiveRecord::Migration
  def change
    change_column :spree_products, :duration, :integer
  end
end
