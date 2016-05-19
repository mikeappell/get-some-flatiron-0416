class Organization < ActiveRecord::Base
  include Sortable
  
  has_many :email_addresses
  has_many :users, through: :email_addresses
  has_many :orders
end
