# Spree::ProductsController.class_eval do
#   def index
#     # q = make_query_params(params)
#     # @searcher = Spree::Config.searcher_class.new(params[:activity_type])
#     # @products = @searcher.retrieve_products
#     # After much trial and error, I have decided to let go of spree's default search and implement my own based on sunspot.
#     @current = 'products'
#     @search = Sunspot.search(Spree::Variant) do
#       with :is_active, true
#       @products = @search.results
#     end
#   end
  

#   private
#   def make_query_params(params)
#     q = ""
#     Spree::Product::SEARCH_FIELDS.each do |field|
#       if params[field]
#         q += params[field]
#       end
#     end
#     return q
#   end
# end
