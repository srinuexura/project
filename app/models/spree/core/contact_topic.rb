module Spree
  class ContactTopic < ActiveRecord::Base
    attr_accessible :name, :email, :order_number, :message
    validates :name, :emails, :presence => true
    validates :name,          :uniqueness => true
  end
end
