class User < ActiveRecord::Base
  include Sortable
  has_many :email_addresses
  has_many :organizations, through: :email_addresses
  has_many :user_orders
  has_many :orders, through: :user_orders
  has_many :admin_orders, class_name: "Order", foreign_key: "admin_id"
  has_many :items

  has_secure_password
  accepts_nested_attributes_for :email_addresses
  before_create :confirmation_token
  
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save
  end


  private
  def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
  end
end
