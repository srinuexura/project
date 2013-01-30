Spree::Variant.class_eval do
  

  after_update :reindex_everything

  # Accessible attrs

  [:bookable_from, :bookable_to, :activity_type_name, :duration, :level, :city].each do |meth|
    define_method meth do
      self.product.send meth 
    end
  end

  def bookable_on_dow
    bookable_on.strftime('%A').downcase
  end

  def exura_available?
    if !deleted_at && !is_master? && on_hand > 0
      return true
    else
      return false
    end
  end

  def available_on
    product.available_on
  end

  searchable do
    text :name
    string :activity_type_name, :using => :activity_type_name
    string :level, :using => :level
    string :city, :using => :city
    integer :price 
    time   :bookable_from, :trie => true
    time   :bookable_to, :trie => true
    # boolean :exura_available, :using => :exura_available?
  end


  
  def reindex_everything
    index
  end
  
end
