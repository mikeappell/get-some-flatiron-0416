require 'rails_helper'
RSpec.describe UsersController, type: :controller do

  FIXTURES_PATH = Rails.root.join("spec", "fixtures")

  before do
    User.destroy_all
    EmailAddress.destroy_all
    # @user = User.create!(name: "Captain Ploonet", username: "IloveGaeo247", venmo: "GuoaFin313", password: "we're the pleenarteers, you can be one three! one three! one two potato!", email_confirmed: true)
    # @email = EmailAddress.create!(email_address: "fake-o@heehee.com", confirmed: false, confirm_token: "best confirm token ever", user: @user)
  end

  describe "#create" do

    context "valid user" do
      it "creates a new user" do
        post :create, {user: {name: "Captain Ploonet", username: "IloveGaeo247", venmo: "GuoaFin313", password: "we're the pleenarteers, you can be one three! one three! one two potato!", email_addresses_attributes: [email_address: "fake-r@heehee.com"]}}
        expect(User.last.name).to eq("Captain Ploonet")
        expect(User.last.username).to eq("IloveGaeo247")
        expect(User.last.venmo).to eq("GuoaFin313")
        expect(User.last.email_addresses.last.email_address).to eq("fake-r@heehee.com")
      end

      it "creates a new user and sends them a registration email" do
        post :create, {user: {name: "Captain Ploonet", username: "IloveGaeo247", venmo: "GuoaFin313", password: "we're the pleenarteers, you can be one three! one three! one two potato!", email_addresses_attributes: [email_address: "fake-r@heehee.com"]}}
        @email = ActionMailer::Base.deliveries.last
        expect(ActionMailer::Base.deliveries.length).to eq(1)
        expect(@email.from).to eq(["getsomelunch1@gmail.com"])
        expect(@email.to).to eq(["fake-r@heehee.com"])
        expect(@email.subject).to eq("Registration Confirmation")
      end

      it "creates a new user and redirects them to login_path" do
        post :create, {user: {name: "Captain Ploonet", username: "IloveGaeo247", venmo: "GuoaFin313", password: "we're the pleenarteers, you can be one three! one three! one two potato!", email_addresses_attributes: [email_address: "fake-r@heehee.com"]}}
        expect(flash[:notice]).to eq("Almost there! Please click the link in your email to complete your registration")
        expect(response).to redirect_to "/login"
      end
    end

    context "invalid user" do
      it "does not send an email" do
        post :create, {user: {name: "Captain Plantaganet", username: "IloveGaeo247", venmo: "GuoaFin313"}}
        expect(ActionMailer::Base.deliveries.length).to eq(0)
      end

      it "does not create a new user" do
        post :create, {user: {name: "Captain Ploonet", username: "IloveGaeo247", venmo: "GuoaFin313" }}
        expect(User.last).to be_nil
        expect(EmailAddress.last).to be_nil
      end

      it "renders registrations/new" do
        post :create, {user: {name: "Captain Ploonet", username: "IloveGaeo247", venmo: "GuoaFin313" }}
        binding.pry
        # expect(response).to render_template('registrations/new')
        expect(current_path).to eq('/signup')
        # expect(flash.now[:alert]).to eq("Signup Failed")
      end
    end
  end
end