class RenameDateRangeFields < ActiveRecord::Migration
  def change
    rename_column :date_ranges, :end_at,    :ends_at
    change_column :date_ranges, :starts_at, :date
    change_column :date_ranges, :ends_at,   :date
  end
end
