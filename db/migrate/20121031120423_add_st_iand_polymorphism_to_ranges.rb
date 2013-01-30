class AddStIandPolymorphismToRanges < ActiveRecord::Migration
  def change
    add_column :date_ranges, :type,           :string
    add_column :date_ranges, :rangeable_id,   :integer
    add_column :date_ranges, :rangeable_type, :string
  end
end
