class AddFieldsToActivities < ActiveRecord::Migration
  def change
    add_column :spree_products, :level,                       :string

    add_column :spree_products, :min_passengers_reqd,         :integer
    add_column :spree_products, :max_passengers_reqd,         :integer

    # Number of trips per day on every weekday
    add_column :spree_products, :no_of_trips_on_mon,          :integer
    add_column :spree_products, :no_of_trips_on_tue,          :integer
    add_column :spree_products, :no_of_trips_on_wed,          :integer
    add_column :spree_products, :no_of_trips_on_thu,          :integer
    add_column :spree_products, :no_of_trips_on_fri,          :integer
    add_column :spree_products, :no_of_trips_on_sat,          :integer
    add_column :spree_products, :no_of_trips_on_sun,          :integer
    
    add_column :spree_products, :min_age,                     :integer
    add_column :spree_products, :max_age,                     :integer
    
    # HTML Fields
    add_column :spree_products, :facilities,                  :string
    add_column :spree_products, :items_to_bring,              :string    
    add_column :spree_products, :cancellation_policy,         :string    
    add_column :spree_products, :overview,                    :string    
    add_column :spree_products, :highlights,                  :string    
    add_column :spree_products, :features,                    :string    
    add_column :spree_products, :exclusions,                  :string    
  end
end
