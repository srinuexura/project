Spree::Taxon.class_eval do

  # Instance Methods

  def is_activity_type?
    self.parent_id == Spree::Taxon.find_by_name('Activities').id
  end

  def activity_count
    if is_activity_type?
      self.products.count
    end
  end

  def active_activities_count
    if is_activity_type?
      self.products.active.count
    end
  end

  def lowest_price_variant
    x = products.map{|p| p.lowest_price_variant}
    x.sort_by {|x| x.price}.first
  end

  def prices_starting_from
    products.sort_by{|x| x.price}.first.price
  end


 
end

  # Class Methods
  
Spree::Taxon.instance_eval do
  def all_activity_types
    act_id = Spree::Taxon.find_by_name('Activities').id
    where :parent_id => act_id
  end
  
end
