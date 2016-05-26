
#### note: for optimal demo experience, sign in as: applessed (password: "password")

Time.zone = "EST"

u_johnny = User.create(name: "Johnny Apple", username: "appleseed", venmo: "mrApple", password: "password", email_confirmed: true)
org_flatiron = Organization.create(domain_name: "flatironschool.com")
e_johnny = EmailAddress.create(user: u_johnny, organization: org_flatiron, email_address: "johnny@flatironschool.com", confirmed: true)

u_george = User.create(name: "George Mason", username: "georgeofjungle", venmo: "JungleBoy", password: "password", email_confirmed: true)
e_george = EmailAddress.create(user: u_george, organization: org_flatiron, email_address: "george@flatironschool.com", confirmed: true)

u_cindy = User.create(name: "Cindy Cinder", username: "burntocinder", venmo: "cinderwoman", password: "password", email_confirmed: true)
e_cindy = EmailAddress.create(user: u_cindy, organization: org_flatiron, email_address: "cindy@flatironschool.com", confirmed: true)

u_camille = User.create(name: "Camille Beef", username: "chameleon", venmo: "beef", password: "password", email_confirmed: true)
e_camille = EmailAddress.create(user: u_camille, organization: org_flatiron, email_address: "camille@flatironschool.com", confirmed: true)

u_james = User.create(name: "James Bond", username: "doubleoh7", venmo: "007", password: "password", email_confirmed: true)
e_james = EmailAddress.create(user: u_james, organization: org_flatiron, email_address: "james@flatironschool.com", confirmed: true)

#### groups for flatiron organization
g_flatironNYC = Group.create(name: "Flatiron NYC", organization: org_flatiron)
g_flatironNYC.users << u_johnny << u_george << u_cindy << u_camille << u_james

g_flatironBrooklyn = Group.create(name: "Flatiron Brooklyn", organization: org_flatiron)
g_flatironBrooklyn.users << u_johnny << u_camille << u_james

####note: order by johnny for flatiron school NYC--
r_bento = Restaurant.create(name: "Bento", url: Faker::Internet.url)
o_bento = Order.create(organization: org_flatiron , date_ordered: DateTime.now, expiration: (DateTime.now + 1.hours), admin: u_johnny, restaurant: r_bento, description: "Because Japanese food is the bomb diggity", minimum_cost: 30, group: g_flatironNYC, image_url: Order.seed_image)

johnny_item = Item.create(name: "medium brocoli chicken (no sesame please)", cost: 5.50, order: o_bento, user: u_johnny)
george_item = Item.create(name: "small brown rice", cost: 2.25, order: o_bento, user: u_george)
cindy_item = Item.create(name: "large vegetarians sushi roll", cost: 6.00, order: o_bento, user: u_cindy)

####note: order by george for flatiron school NYC
r_jamaicanstand = Restaurant.create(name: "The Jamaican Stand", url: Faker::Internet.url)
o_jamaicanstand = Order.create(organization: org_flatiron , date_ordered: DateTime.now, expiration: (DateTime.now + 2.hours), admin: u_george, restaurant: r_jamaicanstand, description: "Who knew they delivered?", minimum_cost: 10, group: g_flatironNYC, image_url: Order.seed_image)

cindy_item = Item.create(name: "large jamaican beef platter", cost: 10.00, order: o_jamaicanstand, user: u_cindy)
camille_item = Item.create(name: "small spicy fries", cost: 2.50, order: o_jamaicanstand, user: u_camille)

####note: order by johhny for flatiron school Brooklyn --
r_tgifridays = Restaurant.create(name: "TGI Fridays", url: Faker::Internet.url)
o_tgifridays = Order.create(organization: org_flatiron , date_ordered: DateTime.now, expiration: (DateTime.now + 1.5.hours), admin: u_camille, restaurant: r_tgifridays, description: "Everybody join this order. I want Friday!", minimum_cost: 25, group: g_flatironBrooklyn, image_url: Order.seed_image)

####note: order by camille for flatiron school Brooklyn --
r_kfc = Restaurant.create(name: "KFC", url: Faker::Internet.url)
o_kfc = Order.create(organization: org_flatiron , date_ordered: DateTime.now, expiration: (DateTime.now + 2.2.hours), admin: u_camille, restaurant: r_kfc, description: "Chicken. 'Nuff said", minimum_cost: 30, group: g_flatironBrooklyn, image_url: Order.seed_image)

james_item = Item.create(name: "small fried chicken", cost: 5.00, order: o_kfc, user: u_james)
camille_item = Item.create(name: "large fountain diet coke", cost: 3.00, order: o_kfc, user: u_camille)

###note: new org: chase bank
org_chasebank = Organization.create(domain_name: "chase.com")
e_johnny_chase = EmailAddress.create(user: u_johnny, organization: org_chasebank, email_address: "johnny@chase.com", confirmed: true)

u_bob = User.create(name: "Bob Bob", username: "bobby", venmo: "bobbybob", password: "password", email_confirmed: true)
e_bob_chase = EmailAddress.create(user: u_bob, organization: org_chasebank, email_address: "bob@chase.com", confirmed: true)

####note: groups for chase bank
g_chase115fifth = Group.create(name: "Chase115Fifth", organization: org_chasebank)
g_chase115fifth.users << u_johnny << u_bob

#### note: order by bob for chase bank
r_bento_chase = Restaurant.create(name: "Bento", url: Faker::Internet.url)
o_bento_chase = Order.create(organization: org_chasebank, date_ordered: DateTime.now, expiration: (DateTime.now + 5.hours), admin: u_bob, restaurant: r_bento_chase, description: "We can make more money by eating from Bento", minimum_cost: 30, group: g_chase115fifth, image_url: Order.seed_image)

bob_item = Item.create(name: "small white fish sushi roll", cost: 3.00, order: o_bento_chase, user: u_bob)


#### note: Shmuel, Steve, JJ, Mike user profiles
u_steve = User.create(name: "Stevie Gonazalez", username: "Sgon", venmo: "ImRich", password: "password", email_confirmed: true)
u_jj = User.create(name: "JJJ Seabird", username: "JJJ", venmo: "JayJayJay", password: "password", email_confirmed: true)
u_shmuel = User.create(name: "Shmwell Lambda", username: "Shmoo", venmo: "ChaChing", password: "password", email_confirmed: true)
u_mike = User.create(name: "Mikall Appleseed", username: "Mikall", venmo: "ShowMeTheMoney", password: "password", email_confirmed: true)

e_steve = EmailAddress.create(user: u_steve, organization: org_flatiron, email_address: "steven.goodstein@flatironschool.com", confirmed: true )
e_jj = EmailAddress.create(user: u_jj, organization: org_flatiron, email_address: "jj.seymour@flatironschool.com", confirmed: true )
e_shmuel = EmailAddress.create(user: u_shmuel, organization: org_flatiron, email_address: "samuel.lamm@flatironschool.com", confirmed: true )
e_mike = EmailAddress.create(user: u_mike, organization: org_flatiron, email_address: "michael.alpert-appell@flatironschool.com", confirmed: true )

g_flatironNYC.users << u_steve << u_jj << u_shmuel << u_mike
g_flatironBrooklyn.users << u_steve << u_jj << u_shmuel << u_mike

#### test order for recent orders
r_carvels = Restaurant.create(name: "Carvels", url: Faker::Internet.url)
o_carvels = Order.create(organization: org_flatiron , date_ordered: (DateTime.now - 5.hours), expiration: (DateTime.now - 6.hours), admin: u_johnny, restaurant: r_carvels, description: "For Ivo's birthday party!!!", minimum_cost: 30, group: g_flatironNYC, image_url: Order.seed_image)

=begin
names = []
5.times { names << Faker::Name.name }

u1 = User.create(name: names.pop, username: "angelface232", venmo: "mrAngel", password: "angels", email_confirmed: true)
u2 = User.create(name: names.pop, username: "bawbby82", venmo: "mrbob", password: "yellow", email_confirmed: true)
u3 = User.create(name: names.pop, username: "daunte29", venmo: "daunting", password: "bananna", email_confirmed: true)
u4 = User.create(name: names.pop, username: "mcGrowler", venmo: "growlerFace", password: "123456", email_confirmed: true)
u5 = User.create(name: names.pop, username: "Roxanna", venmo: "FoxyRoxy", password: "password", email_confirmed: true)
=end
=begin


r1 = Restaurant.create(name: Faker::Name.first_name.pluralize, url: Faker::Internet.url)
r2 = Restaurant.create(name: Faker::Name.first_name.pluralize, url: Faker::Internet.url)
r3 = Restaurant.create(name: Faker::Name.first_name.pluralize, url: Faker::Internet.url)
r4 = Restaurant.create(name: Faker::Name.first_name.pluralize, url: Faker::Internet.url)
r5 = Restaurant.create(name: Faker::Name.first_name.pluralize, url: Faker::Internet.url)

o1 = Organization.create(domain_name: Faker::Internet.domain_name, address: Faker::Address.street_address)
o2 = Organization.create(domain_name: Faker::Internet.domain_name, address: Faker::Address.street_address)
o3 = Organization.create(domain_name: Faker::Internet.domain_name, address: Faker::Address.street_address)

g1 = Group.create(name: Faker::Name.first_name.pluralize, organization: o1)
g2 = Group.create(name: Faker::Name.first_name.pluralize, organization: o1)
g3 = Group.create(name: Faker::Name.first_name.pluralize, organization: o2)
g4 = Group.create(name: Faker::Name.first_name.pluralize, organization: o2)


EmailAddress.create(user: u1, organization: o1, email_address: Faker::Internet.email(u1.name), confirmed: true)
EmailAddress.create(user: u2, organization: o1, email_address: Faker::Internet.email(u2.name), confirmed: true)
EmailAddress.create(user: u3, organization: o2, email_address: Faker::Internet.email(u3.name), confirmed: true)
EmailAddress.create(user: u4, organization: o2, email_address: Faker::Internet.email(u4.name), confirmed: true)
EmailAddress.create(user: u5, organization: o3, email_address: Faker::Internet.email(u5.name), confirmed: true)

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
=end
