class AddBookingDateToOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :booking_date, :date
  end
end
