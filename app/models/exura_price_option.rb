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

class ExuraPriceOption < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :spree_product
  has_many   :spree_variants
  
  ## Accessible attrs
  [ :price_on_monday, :price_on_tuesday, :price_on_wednesday, :price_on_thursday, 
    :price_on_friday, :price_on_saturday, :price_on_sunday, :spree_product_id ].each do |a|
      attr_accessible a
    end
  

end
