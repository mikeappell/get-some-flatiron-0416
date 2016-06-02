class User < ActiveRecord::Base
  has_many :email_addresses
  has_many :organizations, through: :email_addresses
  has_many :items
  has_many :orders, through: :items
  has_many :admin_orders, class_name: "Order", foreign_key: "admin_id"
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :messages

  has_secure_password
  accepts_nested_attributes_for :email_addresses

  before_create :confirmation_token

  def email_activate
    email = self.email_addresses.last
    organization = Organization.find_or_create_by(domain_name: email.email_address.split('@')[1] )

    booleans_set(email)
    associate(email, organization)
  end

  def available_groups
    self.organizations.groups
  end

  def user_sorted_recent_orders
    sorted_orders = (orders.all + admin_orders).uniq.sort_by{|order| order.expiration}.reverse
    sorted_orders.select { |order| (Time.zone.now - order.expiration) < 12.hours }
  end


  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def associate(email, organization)
    email.organization = organization
    email.save
  end

  def booleans_set(email)
    self.email_confirmed = true
    email.confirmed = true
    self.confirm_token = nil
    save
  end

end
