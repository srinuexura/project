class CreateExuraPriceOptions < ActiveRecord::Migration
  def change
    ## Moving price options from product to a separate model
    create_table :exura_price_options do |t|
      Date::DAYNAMES.each do |dow|
        t.integer :"price_on_#{dow.downcase}"
      end
      t.integer :spree_product_id
      t.integer :price_option_value_id
      t.timestamps
    end
    
    Date::DAYNAMES.each do |dow|
      remove_column :spree_products , :"price_on_#{dow.downcase}"
    end
  end
end
