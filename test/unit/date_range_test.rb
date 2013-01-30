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

require 'test_helper'

class DateRangeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
