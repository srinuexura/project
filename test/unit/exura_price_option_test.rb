# == Schema Information
#
# Table name: exura_price_options
#
#  id                    :integer          not null, primary key
#  price_on_sunday       :integer
#  price_on_monday       :integer
#  price_on_tuesday      :integer
#  price_on_wednesday    :integer
#  price_on_thursday     :integer
#  price_on_friday       :integer
#  price_on_saturday     :integer
#  spree_product_id      :integer
#  price_option_value_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'test_helper'

class ExuraPriceOptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
