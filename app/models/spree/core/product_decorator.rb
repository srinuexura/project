
## Add instance methods
Spree::Product.class_eval do
  
  # has_many :exura_price_options


  # Constants
  LEVELS = ['Easy', 'Moderate', 'Difficult', 'Strenuous', 'Exploratory']
  TAB_FIELDS = ['overview', 'highlights', 'features', 'exclusions']
  LIST_OF_STATES = ['Andaman and Nicobar', 'Daman and Diu', 'Delhi - NCT', 'Tamil Nadu', 
                    'Karnataka', 'Maharashtra', 'Jammu and Kashmir', 'Himanchal Pradesh',
                    'Orissa', 'West Bengal', 'Maharashtra', 'Kerala', 'Mizoram', 'Tripura',
                    'Nagaland', 'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar',
                    'Chandigarh', 'Chhattisgarh', 'Dadra and Nagar Haveli', 'Goa',
                    'Gujarat', 'Meghalaya', 'Pondicherry', 'Punjab', 'Sikkim',
                    'Uttarakhand', 'Uttar Pradesh', 'Rajasthan', 'Madhya Pradesh'
                   ].uniq.sort
  PRODUCT_TYPES  = [ "Regular Activity", "Fixed Group Size Activity"]

  # Accessible attrs
  tmp = [:level, :category, :level, :category, :facilities, :items_to_bring,
         :min_passengers_reqd, :max_passengers_reqd, :overview, :highlights, :features, :exclusions, :cancellation_policy,
         :latitude, :longitude, :zoom_level, :street_address, :city, :state, :duration, :on_hand_on_sunday, :on_hand_on_monday, :on_hand_on_tuesday,
         :on_hand_on_wednesday, :on_hand_on_thursday, :on_hand_on_friday,:on_hand_on_saturday, :product_type, :price_per_day,
         :featured, :activity_type, :bookable_from, :bookable_to
        ].each do |attr|
    attr_accessible attr
  end

  before_update :create_or_update_variants
  
  before_save   :validate_bookable_dates

  def add_requisite_option_types
    # o = Spree::OptionType.find_by_name("Child / Adult / Both")
    # option_types << o unless option_types.include?(o)
    o = Spree::OptionType.find_by_name("Bookable on")
    option_types << o unless option_types.include?(o)
  end

  def create_or_update_variants 
    # ot = Spree::OptionType.find_by_name("Bookable on")
    # debugger
    # if booking_range_is_valid?
    #   (bookable_from..bookable_to).each do |bookable_on|
    #     v = Spree::Variant.new
    #     v.bookable_on = bookable_on
    #     ov = ot.option_values.detect { |d| Date.parse(d.presentation) == bookable_on }
    #     v.option_values << ov
    #     v.name = name
    #     v.product = self
    #     # v.price   = self.send :"price_on_#{v.bookable_on_dow}"
    #     v.on_hand = self.send :"on_hand_on_#{v.bookable_on_dow}"
    #     v.save
    #   end
    # end
  end
  
  def booking_range_is_valid?
    ! (bookable_from.blank? || bookable_to.blank? || bookable_from > bookable_to)
  end

  def validate_bookable_dates
    unless bookable_from.blank?
      if bookable_to.blank? || bookable_to < bookable_from
        errors.add :bookable_to
      end
    end
  end


  def is_active?
    !deleted_at && available_on &&
      (available_on <= Time.zone.now)
        # && (Spree::Config[:allow_backorders] || count_on_hand > 0)
  end


















  # Validations
  # validates_numericality_of :zoom_level, :unless => :new_record?
  # validates_presence_of :latitude, :longitude, :unless => :new_record?
  validates_presence_of :street_address, :city, :state
  validates :product_type, :inclusion => { :in => PRODUCT_TYPES }
  validates :level, :inclusion => { :in => LEVELS }, :unless => :new_record?

  # Validations specific to fixed group sized activity
  # validates :min_passengers_reqd, :max_passengers_reqd, :presence => true, :numericality => true, :if => :is_fixed_group_size_activity?

  # adds #is_regular_activity? and #is_fixed_group_size_activity?
  PRODUCT_TYPES.each do |t|
    define_method "is_#{t.downcase.gsub(' ', '_')}?" do
      if self.product_type
        return self.product_type == t
      else
        return false
      end
    end
  end


  # Check availability on a Day of the Week (dow param as 'mon', 'tue' etc)
  def available_on_dow?(dow)
    dow = dow.downcase
    if count_on_dow(dow) && count_on_dow(dow) > 0
      true
    else
      false
    end
  end
  def count_on_dow(dow)
    dow = dow.downcase
    self.send "on_hand_on_#{dow}".to_sym
  end

  # This is for google maps
  acts_as_gmappable :process_geocoding => false
  def gmaps4rails_address
    self.location
  end
  
  def box_image
    self.images[0] || false
  end

  def activity_type
    self.taxons.where(:parent_id => Spree::Taxon.find_by_name('Activities').id).first
  end

  def activity_type_name
    unless activity_type.nil?
      activity_type.name 
    else 
      "N/A"
    end
  end


  def location
    "#{self.city}, #{self.state}"
  end


  # Override the available? method to check for availability on a given date
  def available?
    true
  end

  # Child and Adult 
  ['child', 'adult', 'both'].each do |meth|
    define_method "variant_for_#{meth.pluralize}" do
      res = nil
      self.variants.each do |var|
        var.option_values.each do |opt|
          if opt.name == "Variant for #{meth.pluralize}"
            res = var
          end
        end
      end
      return res
    end
    define_method "price_per_#{meth}" do
      var = self.send "variant_for_#{meth.pluralize}"
      return var.price if var
    end
  end
  
  def price_today
    dow = Date::DAYNAMES[Time.now.wday]
    p = self.send :"price_on_#{dow.downcase}"
      if p.blank? 
        return p 
      else
        return spree_price
      end
  end

  
  # Override Spree's default price method to match price today and price on booking day



  def lowest_price_variant
    variants.order(:price, 'ASC').first
  end

  def prices_starting_from
    lowest_price_variant.price
  end



  def reindex
    index!
  end


end


## Add class methods
Spree::Product.instance_eval do


  def activities_list
    Spree::Taxon.where(:parent_id => Spree::Taxon.find_by_name('Activities').id)
  end

  def activities_names_list
    arr = []
    activities_list.each do |act|
      arr << act.name
    end
    return arr
  end

  def non_empty_activities_names_list
    arr = []
    activities_list.each do |act|
      if act.products.any?
        arr << act.name
      end
    end
    return arr
  end


  def active_cities_list
    arr = []
    Spree::Product.active.each do |p|
      arr << p.city.titleize rescue ''
    end
    arr.uniq
  end

  def all_cities_list
    arr = []
    Spree::Product.all.each do |p|
      arr << p.city.titleize rescue ''
    end
    arr.uniq
  end

  ## Scopes
  def featured
    where(:featured => true)
  end

  


end

