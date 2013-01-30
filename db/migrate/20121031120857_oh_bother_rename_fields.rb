class OhBotherRenameFields < ActiveRecord::Migration
  def change
    Date::DAYNAMES.each do |dow|
      rename_column :spree_products, :"price_on_#{dow}", :"price_on_#{dow.downcase}"
    end
  end

end
