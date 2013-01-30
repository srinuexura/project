Spree::Admin::VariantsController.class_eval do
  
  def new
    @variant = Spree::Variant.new
  end

  def edit
    @variant = Spree::Variant.find params[:id]
  end
  
end
