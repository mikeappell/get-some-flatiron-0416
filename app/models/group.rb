class Group < ActiveRecord::Base
  belongs_to :organization
  has_many :users, through: :organization
end
