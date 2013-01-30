# == Schema Information
#
# Table name: date_ranges
#
#  id             :integer          not null, primary key
#  starts_at      :date
#  ends_at        :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  type           :string(255)
#  rangeable_id   :integer
#  rangeable_type :string(255)
#

class DateRange < ActiveRecord::Base

  attr_accessible :starts_at, :ends_at, :rangeable_id, :rangeable_type
  belongs_to :rangeable, :polymorphic => true
  
  def after_initialize
    self.starts_at ||= DateTime.now
    self.end_at ||= DateTime.now
  end

end

  
