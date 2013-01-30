class AddDailyStockToVariants < ActiveRecord::Migration
  def change
    Date::DAYNAMES.each do |day|
      add_column :spree_variants, "on_hand_on_#{day.downcase}".to_sym, :int
    end
  end
end
