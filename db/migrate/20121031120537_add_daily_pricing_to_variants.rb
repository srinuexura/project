class AddDailyPricingToVariants < ActiveRecord::Migration
  def change
    Date::DAYNAMES.each do |day|
      add_column :spree_variants, "price_on_#{day.downcase}".to_sym, :decimal
    end
  end
end
