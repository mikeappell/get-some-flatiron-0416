# class EmailAddressHelpers
#
#   def initialize(email)
#     @domain = find_domain(email)[1]
#     @organization = find_organization(@domain)
#   end
#
#   def find_domain(email)
#     /@(.+)/.match(email)
#   end
#
#   def find_organization(domain_name)
#     Organization.find_or_create_by(domain_name: domain_name)
#   end
#
#   def handle_email(email_params)
#     email_address = new_email(email_params)
#     if email_address.save
#       send_email(email_address)
#       page_redirect
#     else
#       page_render
#     end
#   end
#
#   def new_email(email_params)
#     EmailAddress.new(EmailAddress.new(email_params)
#   end
#
#   def send_email(email_address)
#     RegistrationMailer.email_confirmation(current_user, @email_address).deliver_now
#   end
#
#   def page_redirect
#     flash[:notice] = "Almost there! Please click the link in your email to complete your registration"
#     redirect_to edit_user_path(current_user)
#   end
#
#   def page_render
#     render 'users/edit', alert: "That Email is not valid"
#   end
#
# end
