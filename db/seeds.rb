# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
names = []
5.times { names = Faker::Name.name }

u1 = User.create(name: names.pop, username: "angelface232", venmo: "mrAngel", password: "angels")
u2 = User.create(name: names.pop, username: "bawbby82", venmo: "mrbob", password: "yellow")
u3 = User.create(name: names.pop, username: "daunte29", venmo: "daunting", password: "bananna")
u4 = User.create(name: names.pop, username: "mcGrowler", venmo: "growlerFace", password: "123456")
u5 = User.create(name: names.pop, username: "Roxanna", venmo: "FoxyRoxy", password: "password")

r1 = Restuarant.create(name: Faker::Name.first_name.pluralize, url: Faker::Internet.url)
r2 = Restuarant.create(name: Faker::Name.first_name.pluralize, url: Faker::Internet.url)
r3 = Restuarant.create(name: Faker::Name.first_name.pluralize, url: Faker::Internet.url)
r4 = Restuarant.create(name: Faker::Name.first_name.pluralize, url: Faker::Internet.url)
r5 = Restuarant.create(name: Faker::Name.first_name.pluralize, url: Faker::Internet.url)

o1 = Oranization.create(name: Faker::Name.first_name.pluralize, domain_name: Faker::Internet.domain_name)
o2 = Oranization.create(name: Faker::Name.first_name.pluralize, domain_name: Faker::Internet.domain_name)
o3 = Oranization.create(name: Faker::Name.first_name.pluralize, domain_name: Faker::Internet.domain_name)


EmailAddress.create(user_id: u1, organization_id: o1, email_address: Faker::Internet.email(u1.name))
EmailAddress.create(user_id: u2, organization_id: o1, email_address: Faker::Internet.email(u2.name))
EmailAddress.create(user_id: u3, organization_id: o2, email_address: Faker::Internet.email(u3.name))
EmailAddress.create(user_id: u4, organization_id: o2, email_address: Faker::Internet.email(u4.name))
EmailAddress.create(user_id: u5, organization_id: o3, email_address: Faker::Internet.email(u5.name))

order1 = Order.create(organization_id: o1, date_ordered: DateTime.new(2015, 8, 29))
