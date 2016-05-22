class EmailAddress < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  validates :email_address, uniqueness: true
  validates :email_address, presence: true

  before_create :confirmation_token

  def email_address_activate
    self.confirmed = true
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
