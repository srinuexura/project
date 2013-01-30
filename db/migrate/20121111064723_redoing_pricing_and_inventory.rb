class RedoingPricingAndInventory < ActiveRecord::Migration
  def change
    [:price_per_day, :price_on_monday, :price_on_tuesday,
     :price_on_wednesday, :price_on_thursday, :price_on_friday,
     :price_on_saturday, :price_on_sunday
    ].each do |field|
      
      remove_column :spree_variants, field
    end
  end
end
