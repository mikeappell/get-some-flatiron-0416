names = []
5.times { names << Faker::Name.name }

u1 = User.create(name: "Bobby Bouflay", username: "bobby", venmo: "bobby82", password: "bob", email_confirmed: true)
u2 = User.create(name: names.pop, username: "angelface232", venmo: "mrAngel", password: "angels", email_confirmed: true)
u3 = User.create(name: names.pop, username: "bawbby82", venmo: "mrbob", password: "yellow", email_confirmed: true)
u4 = User.create(name: names.pop, username: "daunte29", venmo: "daunting", password: "bananna", email_confirmed: true)
u5 = User.create(name: names.pop, username: "mcGrowler", venmo: "growlerFace", password: "123456", email_confirmed: true)
u6 = User.create(name: names.pop, username: "Roxanna", venmo: "FoxyRoxy", password: "password", email_confirmed: true)
u7 = User.create(name: "Jackie June", username: "JackJune", venmo: "PayMe", password: "abc", email_confirmed: true)

u8 = User.create(name: "Stevie Gonazalez", username: "Sgon", venmo: "ImRich", password: "asdf", email_confirmed: true)
u9 = User.create(name: "JJJ Seabird", username: "JJJ", venmo: "JayJayJay", password: "asdf", email_confirmed: true)
u10 = User.create(name: "Shmwell Lambda", username: "Shmwell", venmo: "ChaChing", password: "asdf", email_confirmed: true)
u11 = User.create(name: "Mikall Appleseed", username: "Mikall", venmo: "ShowMeTheMoney", password: "asdf", email_confirmed: true)

r1 = Restaurant.create(name: Faker::Name.first_name.pluralize, url: Faker::Internet.url)
r2 = Restaurant.create(name: Faker::Name.first_name.pluralize, url: Faker::Internet.url)
r3 = Restaurant.create(name: Faker::Name.first_name.pluralize, url: Faker::Internet.url)
r4 = Restaurant.create(name: Faker::Name.first_name.pluralize, url: Faker::Internet.url)
r5 = Restaurant.create(name: Faker::Name.first_name.pluralize, url: Faker::Internet.url)

o1 = Organization.create(domain_name: "Flatironschool.com")
o2 = Organization.create(domain_name: "berkshire.com")
o3 = Organization.create(domain_name: Faker::Internet.domain_name)

g1 = Group.create(name: "Flatiron SF", organization: o1)
g2 = Group.create(name: "Flatiron NYC", organization: o1)
g3 = Group.create(name: Faker::Name.first_name.pluralize, organization: o2)
g4 = Group.create(name: Faker::Name.first_name.pluralize, organization: o2)


EmailAddress.create(user: u1, organization: o1, email_address: "bobarang@Flatironschool.com", confirmed: true)
EmailAddress.create(user: u1, organization: o2, email_address: "bobby@berkshire.com", confirmed: true )
EmailAddress.create(user: u2, organization: o1, email_address: Faker::Internet.email(u2.name), confirmed: true)
EmailAddress.create(user: u3, organization: o2, email_address: Faker::Internet.email(u3.name), confirmed: true)
EmailAddress.create(user: u4, organization: o2, email_address: Faker::Internet.email(u4.name), confirmed: true)
EmailAddress.create(user: u5, organization: o3, email_address: Faker::Internet.email(u5.name), confirmed: true)
EmailAddress.create(user: u7, organization: o1, email_address: "jackie@berkshire.com", confirmed: true )

EmailAddress.create(user: u8, organization: o1, email_address: "steven.goodstein@Flatironschool.com", confirmed: true )
EmailAddress.create(user: u9, organization: o1, email_address: "jj.seymour@Flatironschool.com", confirmed: true )
EmailAddress.create(user: u10, organization: o1, email_address: "samuel.lamm@Flatironschool.com", confirmed: true )
EmailAddress.create(user: u11, organization: o1, email_address: "michael.alpert-appell@Flatironschool.com", confirmed: true )



order1 = Order.create(organization: o1, date_ordered: DateTime.new(2015, 8, 29, 4, 55, 5), expiration: DateTime.new(2015, 8, 29, 5, 2, 4), admin: u1, restaurant: r1, description: Faker::Hipster.sentence, minimum_cost: Faker::Number.decimal(2, 2), group: g1)
order2 = Order.create(organization: o1, date_ordered: DateTime.new(2015, 8, 29, 3, 55, 5), expiration: DateTime.new(2015, 8, 29, 4, 20, 4), admin: u2, restaurant: r2, description: Faker::Hipster.sentence, minimum_cost: Faker::Number.decimal(2, 2), group: g2)
order3 = Order.create(organization: o2, date_ordered: DateTime.new(2015, 8, 29, 4, 55, 5), expiration: DateTime.new(2015, 8, 29, 5, 2, 4), admin: u3, restaurant: r3, description: Faker::Hipster.sentence, minimum_cost: Faker::Number.decimal(2, 2), group: g3)
order4 = Order.create(organization: o3, date_ordered: DateTime.new(2015, 8, 29, 4, 55, 5), expiration: DateTime.new(2015, 8, 29, 5, 2, 4), admin: u5, restaurant: r4, description: Faker::Hipster.sentence, minimum_cost: Faker::Number.decimal(2, 2))

item1 = Item.create(name: Faker::Beer.name, cost: Faker::Number.decimal(2, 2), order: order1, user: u1)
item2 = Item.create(name: Faker::Beer.name, cost: Faker::Number.decimal(2, 2), order: order1, user: u2)
item3 = Item.create(name: Faker::Beer.name, cost: Faker::Number.decimal(2, 2), order: order1, user: u1)
item4 = Item.create(name: Faker::Beer.name, cost: Faker::Number.decimal(2, 2), order: order1, user: u2)
item5 = Item.create(name: Faker::Beer.name, cost: Faker::Number.decimal(2, 2), order: order2, user: u2)
item6 = Item.create(name: Faker::Beer.name, cost: Faker::Number.decimal(2, 2), order: order2, user: u1)
item7 = Item.create(name: Faker::Beer.name, cost: Faker::Number.decimal(2, 2), order: order3, user: u3)
item8 = Item.create(name: Faker::Beer.name, cost: Faker::Number.decimal(2, 2), order: order3, user: u3)
item9 = Item.create(name: Faker::Beer.name, cost: Faker::Number.decimal(2, 2), order: order3, user: u3)
item10 = Item.create(name: Faker::Beer.name, cost: Faker::Number.decimal(2, 2), order: order4, user: u5)

u1.orders << order1 << order2
u2.orders << order1 << order2
u3.orders << order3
u5.orders << order4

u1.groups << g1 << g2
u2.groups << g3 << g1
u4.groups << g4

u8.groups << g1 << g2
u9.groups << g1
u10.groups << g1 << g2
u11.groups << g1
