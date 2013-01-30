Spree::HomeController.class_eval do
  helper 'spree/products'
  respond_to :html
  
  def home_page
    @searcher = Spree::Config.searcher_class.new(params)
    @products = @searcher.retrieve_products
    @featured = Spree::Product.featured
    respond_with(@products, @featured)
  end

  ["Home", "Activities", "Contact", "About Us", "Faqs", "Partners And Operators", "Privacy Policy", "Terms And Conditions"].each do |item|
    url = item.gsub(' ', '').underscore
    define_method url do
      render 'pages/#{url}'
    end
  end
  def show_pages
    @page_name = params[:page_name]
    render :page_name
  end

end
