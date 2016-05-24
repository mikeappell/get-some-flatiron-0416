class Item < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  validates :name, presence: true
  validates :cost, numericality: true, :format => { :with => /\A\d{1,6}(\.\d{0,2})?\z/ }

  def cost_formatted
    split_cost = self.cost.to_s.split(".")
    split_cost[1] = split_cost[1].ljust(2,"0")
    split_cost.join(".")
  end
end
