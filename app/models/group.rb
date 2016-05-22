class Group < ActiveRecord::Base
  belongs_to :organization
  has_many :user_groups
  has_many :users, through: :user_groups
end
