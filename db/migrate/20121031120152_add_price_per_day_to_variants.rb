class AddPricePerDayToVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :price_per_day, :text
  end
end
