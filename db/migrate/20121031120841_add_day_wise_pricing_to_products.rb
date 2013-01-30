class AddDayWisePricingToProducts < ActiveRecord::Migration
  def change
    Date::DAYNAMES.each do |dow|
      add_column :spree_products, :"price_on_#{dow}", :integer
    end
  end
end
