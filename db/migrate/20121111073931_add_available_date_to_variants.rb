class AddAvailableDateToVariants < ActiveRecord::Migration
  def change
    
    add_column :spree_variants, :bookable_on, :date
    
  end
end
