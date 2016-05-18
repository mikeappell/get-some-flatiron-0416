class Organization < ActiveRecord::Base
  has_many :email_addresses
  has_many :users, through: :email_addresses
  has_many :orders
end
