class Item < ActiveRecord::Base
  belongs_to :order
  belongs_to :user

  validates :name, presence: true
end
