class RemoveInventoryFromMaster < ActiveRecord::Migration
  def change
    [:no_of_trips_on_mon, :no_of_trips_on_tue, :no_of_trips_on_wed, 
     :no_of_trips_on_thu, :no_of_trips_on_fri, 
     :no_of_trips_on_sat, :no_of_trips_on_sun].each do |field|
      remove_column :spree_products, field
    end
  end
end
