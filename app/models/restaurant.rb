class Restaurant < ActiveRecord::Base
  has_many :orders
end
