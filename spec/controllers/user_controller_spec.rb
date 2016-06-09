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
        expect(flash.now[:alert]).to eq("Signup Failed")
        expect(response).to render_template 'registrations/new'
      end
    end
  end

  describe "#update" do
    
    let(:test_user) {User.create(name: "Mr. Test", username: "ipasstests", venmo: "mrApple", password: "password", email_confirmed: true)}

    before(:each) do
      allow(controller).to receive(:current_user).and_return(test_user)
    end

    context "changing username" do
      it "updates the username and redirects user back to edit path on a valid username" do
        patch :update, {id: test_user.id, user: {username: "BestNewUsername"}}
        expect(test_user.username).to eq("BestNewUsername")
        expect(response).to redirect_to("/users/#{test_user.id}/edit")
        expect(flash[:alert]).to eq("Your username has been changed")
      end

      it "flashes an alert and re-renders edit on an invalid username" do
        session[:user_id] = User.last.id
        second_user = User.create(name: "Mr. Testy", username: "amazingusername", venmo: "mrMapple", password: "password", email_confirmed: true)
        patch :update, {id: test_user.id, user: {username: "amazingusername"}}
        expect(flash[:alert]).to eq("The username you entered has already been taken")
        expect(response).to render_template 'users/edit'
      end
    end

    context "changing password" do
      it "updates the password and redirects user back to edit path on a valid password" do
        patch :update, {id: test_user.id, user: {password: "BestNewpassword", password_confirmation: "BestNewpassword"}}
        expect(test_user.validate("BestNewpassword")).to be_truthy
        expect(response).to redirect_to("/users/#{test_user.id}/edit")
        expect(flash[:alert]).to eq("Your password has been changed")
      end

      it "flashes an alert and re-renders edit on an invalid password" do
        session[:user_id] = User.last.id
        patch :update, {id: test_user.id, user: {password: "amazingpassword", password_confirmation: "okpassword"}}
        expect(flash[:alert]).to eq("There was a problem with the password you entered")
        expect(response).to render_template 'users/edit'
      end
    end

    context "changing venmo" do
      it "updates the venmo and redirects user back to edit path on a valid venmo" do
        patch :update, {id: test_user.id, user: {venmo: "BestNewvenmo"}}
        expect(test_user.venmo).to eq("BestNewvenmo")
        expect(response).to redirect_to("/users/#{test_user.id}/edit")
        expect(flash[:alert]).to eq("Your Venmo username has been changed")
      end

      it "flashes an alert and re-renders edit on an invalid venmo" do
        session[:user_id] = User.last.id
        second_user = User.create(name: "I.P. Freely", username: "ausername", venmo: "Vroomno", password: "password", email_confirmed: true)
        patch :update, {id: test_user.id, user: {venmo: "Vroomno"}}
        expect(flash[:alert]).to eq("There was a problem with your Venmo username")
        expect(response).to render_template 'users/edit'
      end
    end

  end
end