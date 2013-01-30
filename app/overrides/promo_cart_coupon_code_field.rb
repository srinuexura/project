Deface::Override.new(:virtual_path => "spree/orders/edit",
                     :name => "promo_cart_coupon_code_field",
                     :insert_after => "[data-hook='cart_buttons']",
                     :partial => "spree/orders/coupon_code_field",
                     :disabled => false,
                     # :original => "a79bf2aae7901e7bad02d016a1cb362d86275041"
                     )
