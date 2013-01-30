class CreateDateRanges < ActiveRecord::Migration
  def change
    create_table :date_ranges do |t|
      t.datetime :starts_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
