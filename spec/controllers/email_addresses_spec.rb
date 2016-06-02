require 'rails_helper'

RSpec.describe EmailAddressesController, type: :controller do

  let(:test_user) {User.create(name: "Mr. Test", username: "ipasstests", venmo: "mrApple", password: "password", email_confirmed: true)}

  before(:each) do
    User.destroy_all
    EmailAddress.destroy_all
    Organization.destroy_all
    allow(controller).to receive(:current_user).and_return(test_user)
    @bob_email_address = "bob@bob.com"
   end

  context "makes and associates email addresses and organizations" do
    it "makes a new email address" do
      post :create, {email_address: {email_address: @bob_email_address}}
      created_email_address = EmailAddress.find_by(email_address: @bob_email_address)
      expect(created_email_address.email_address).to eq(@bob_email_address)
    end

    it "check that there will be an organization with the user's domain name if organization does not exist" do
      post :create, {email_address: {email_address: @bob_email_address}}
      found_organization = Organization.find_by(domain_name: "bob.com")
      expect(found_organization).to be_truthy
    end

    it "check that the proper organization with the user's domain name will be found if organization exists" do
      organization = Organization.create(domain_name: "bob.com")
      post :create, {email_address: {email_address: @bob_email_address}}
      expect(organization.users).to include(test_user)
      expect(Organization.count).to eq(1)
    end

    it  "sends an email if email_address could be saved" do
      post :create, {email_address: {email_address: @bob_email_address}}
      expect(ActionMailer::Base.deliveries.length).to eq(1)
    end

    it "it redirects properly" do
      post :create, {email_address: {email_address: @bob_email_address}}
      response.should redirect_to "/users/#{test_user.id}/edit"
    end

  end
end
