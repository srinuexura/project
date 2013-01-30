class MoveInventoryToProductsAgain < ActiveRecord::Migration
  def change
    Date::DAYNAMES.each do |day|
      remove_column :spree_variants, "on_hand_on_#{day.downcase}".to_sym
      add_column :spree_products, "on_hand_on_#{day.downcase}".to_sym, :integer
    end
  end
end
