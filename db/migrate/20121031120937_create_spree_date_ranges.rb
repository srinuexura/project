class CreateSpreeDateRanges < ActiveRecord::Migration
  def change
    create_table :spree_date_ranges do |t|

      t.timestamps
    end
  end
end
