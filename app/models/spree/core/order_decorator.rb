Spree::Order.class_eval do
  
  attr_accessible :booking_date

  checkout_flow do
    go_to_state :address, :if => lambda { |order| order.payment_required? }
    go_to_state :payment, :if => lambda { |order| order.payment_required? }
    go_to_state :confirm, :if => lambda { |order| order.confirmation_required? }
    go_to_state :complete
  end

  state_machine do
    after_transition :from => :cart, :to => :address do |order|
      order.next
    end
  end
  
end



