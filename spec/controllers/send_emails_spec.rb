require 'rails_helper'

RSpec.describe SendEmailsController, type: :controller do

  before(:each) do
    User.destroy_all
    Order.destroy_all
    EmailAddress.destroy_all
    Organization.destroy_all
    Item.destroy_all

    u_johnny = User.create(name: "Johnny Apple", username: "appleseed", venmo: "mrApple", password: "password", email_confirmed: true)
    org_flatiron = Organization.create(domain_name: "flatironschool.com")
    e_johnny = EmailAddress.create(user: u_johnny, organization: org_flatiron, email_address: "johnny@flatironschool.com", confirmed: true)
    u_george = User.create(name: "George Mason", username: "georgeofjungle", venmo: "JungleBoy", password: "password", email_confirmed: true)
    e_george = EmailAddress.create(user: u_george, organization: org_flatiron, email_address: "george@flatironschool.com", confirmed: true)
    u_cindy = User.create(name: "Cindy Cinder", username: "burntocinder", venmo: "cinderwoman", password: "password", email_confirmed: true)
    e_cindy = EmailAddress.create(user: u_cindy, organization: org_flatiron, email_address: "cindy@flatironschool.com", confirmed: true)
    r_bento = Restaurant.create(name: "Bento", url: Faker::Internet.url)

    g_flatironNYC =  Group.create(name: "Flatiron NYC", organization: org_flatiron)
    o_bento = Order.create(organization: org_flatiron , date_ordered: DateTime.now, expiration: (DateTime.now + 1.hours), admin: u_johnny, restaurant: r_bento, description: "Because Japanese food is the bomb diggity", minimum_cost: 30, group: g_flatironNYC, image_url: Order.seed_image)
    george_item = Item.create(name: "small brown rice", cost: 2.25, order: o_bento, user: u_george)
    cindy_item = Item.create(name: "large vegetarians sushi roll", cost: 6.00, order: o_bento, user: u_cindy)
  end

  context "sends emails to correct recipients" do
    it "Finds the correct information from the order on order placed" do
      post :order_placed, {order_id: Order.first.id }
      @email = ActionMailer::Base.deliveries.last

      expect(ActionMailer::Base.deliveries.length).to eq(1)
      expect(@email.from).to eq(["getsomelunch1@gmail.com"])
      expect(@email.bcc).to eq([User.find_by(name: "George Mason").email_addresses.first.email_address, User.find_by(name: "Cindy Cinder").email_addresses.first.email_address])
      expect(@email.subject).to eq("Your Order Has Been Placed!")
      expect(@email.body).to include(Order.first.admin.name)
    end

    it "Finds the correct information from the order on order arrived" do
      post :order_arrived, {order_id: Order.first.id }
      @email = ActionMailer::Base.deliveries.last

      expect(ActionMailer::Base.deliveries.length).to eq(1)
      expect(@email.from).to eq(["getsomelunch1@gmail.com"])
      expect(@email.bcc).to eq([User.find_by(name: "George Mason").email_addresses.first.email_address, User.find_by(name: "Cindy Cinder").email_addresses.first.email_address])
      expect(@email.subject).to eq("Your Order Has Arrived!")
      expect(@email.body).to include(Order.first.admin.name)
    end
  end



end
