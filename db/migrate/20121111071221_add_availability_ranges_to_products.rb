class AddAvailabilityRangesToProducts < ActiveRecord::Migration
  def change

    add_column :spree_products, :bookable_from, :date
    add_column :spree_products, :bookable_to, :date

  end
end
