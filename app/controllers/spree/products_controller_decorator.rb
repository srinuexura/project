Spree::ProductsController.class_eval do
  def index
    @current = 'products'
    @search = Sunspot.search(Spree::Variant) do
      # facet :bookable_on
      # facet :price
      facet :activity_type_name
      facet :city
      facet :level
      fulltext params[:keyword]
      if params[:as].present? && !params[:ae].present?
        with(:bookable_from).less_than(Date.parse(params[:as]).to_time)
        with(:bookable_to).greater_than(Date.parse(params[:as]).to_time)
      end
      if params[:ae].present? && !params[:as].present?
        with(:bookable_from).less_than(Date.parse(params[:ae]).to_time)
        with(:bookable_to).greater_than(Date.parse(params[:ae]).to_time)
      end
      if params[:as].present? && params[:ae].present?
        with(:bookable_from).less_than(Date.parse(params[:as]).to_time)
        with(:bookable_to).greater_than(Date.parse(params[:ae]).to_time)
      end
      if params[:act].present?
        with :activity_type_name, params[:act]
      end
      if params[:lvl].present?
        with :level, params[:lvl]
      end
      if params[:loc].present?
        with :city, params[:loc]
      end
    end
    @products = @search.results
  end
  

end
