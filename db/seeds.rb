# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create!([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create!(name: 'Emanuel', city: cities.first)

Package.create(name: "$32 for $30", credits: 32, price: 30, active: true, phone: true)
Package.create(name: "$55 for $50", credits: 55, price: 50, active: true, phone: true)

INSERT INTO `tiers` VALUES (1,'Bronze',0,999,'2013-09-16 18:46:03','2013-09-16 18:51:38','14.00'),(2,'Silver',1000,1199,'2013-09-16 18:46:24','2013-09-16 18:51:38','19.00'),(3,'Gold',1200,1599,'2013-09-16 18:46:31','2013-09-16 18:51:51','19.50'),(4,'Platinum',1600,1999,'2013-09-16 18:46:43','2013-09-16 18:51:38','20.00'),(5,'Diamond',2000,999999,'2013-09-16 18:47:01','2013-09-16 18:51:38','21.00');

Tier.create(name: 'Bronze',   from: 0, to: 999, percent: 14)
Tier.create(name: 'Silver',   from: 1000, to: 1199, percent: 19)
Tier.create(name: 'Gold',     from: 1200, to: 1599, percent: 19.5)
Tier.create(name: 'Platinum', from: 1600, to: 1999, percent: 20)
Tier.create(name: 'Diamond',  from: 2000, to: 999999, percent: 21)

admin = User.create!(first_name: 'Master', last_name: 'Admin',
                    username: 'admin', email: 'admin@iheartpsychics.co',
                    password: 'ipass123', create_as: 'admin', confirmed_at: Time.now)

wadmin = User.create!(first_name: 'Website', last_name: 'Admin',
                     username: 'wadmin', email: 'wadmin@iheartpsychics.co',
                     password: 'ipass123', create_as: 'website_admin',
                     confirmed_at: Time.now)

mdirector = User.create!(first_name: 'Manager', last_name: 'Director',
                        username: 'mdir', email: 'mdir@iheartpsychics.co',
                        password: 'ipass123', create_as: 'website_admin',
                        confirmed_at: Time.now)

accountant = User.create!(first_name: 'Accountant', last_name: '',
                         username: 'accountant', email: 'accountant@iheartpsychics.co',
                         password: 'ipass123', create_as: 'accountant',
                         confirmed_at: Time.now)

app1 = PsychicApplication.create!(first_name: 'Unfortunate', last_name: 'Teller',
                   username: 'ufteller', email: 'ufteller@iheartpsychics.co',
                   address: '3032 47th St', city: 'Lansing', state: 'MI',
                   zip_code: Faker::Address.zip_code,
                   password: 'ipass123', phone: '+17863295531',
                   cellular_number: '+13054502992',
                   ssn: Faker::Base.regexify(/\d{3}-?\d{2}-?\d{4}/),
                   date_of_birth: "1985-01-01",
                   emergency_contact: Faker::Name.name,
                   emergency_contact_number: "+13044440404",
                   us_citizen: true, has_experience: true,
                   experience: Faker::Lorem.paragraph,
                   gift: Faker::Lorem.words,
                   explain_gift: Faker::Lorem.paragraph,
                   age_discovered: 12,
                   reading_style: Faker::Lorem.paragraph,
                   why_work: Faker::Lorem.paragraph,
                   friends_describe: Faker::Lorem.paragraph,
                   strongest_weakest_attributes: Faker::Lorem.paragraph,
                   how_to_deal_challenging_client: Faker::Lorem.paragraph,
                   specialties: Faker::Lorem.paragraph,
                   tools: Faker::Lorem.paragraph,
                   professional_goals: Faker::Lorem.paragraph,
                   how_did_you_hear: 'Friend')

app2 = PsychicApplication.create!(first_name: 'Trinity', last_name: 'Megan',
                   username: 'tmegan', email: 'trinity@iheartpsychics.co',
                   address: '1022 32nd St', city: 'Miami', state: 'FL',
                   zip_code: Faker::Address.zip_code,
                   password: 'ipass123', phone: '+17863295532',
                   cellular_number: '+13054502993',
                   ssn: Faker::Base.regexify(/\d{3}-?\d{2}-?\d{4}/),
                   date_of_birth: "1985-01-01",
                   emergency_contact: Faker::Name.name,
                   emergency_contact_number: "+13044440404",
                   us_citizen: true, has_experience: true,
                   experience: Faker::Lorem.paragraph,
                   gift: Faker::Lorem.words,
                   explain_gift: Faker::Lorem.paragraph,
                   age_discovered: 12,
                   reading_style: Faker::Lorem.paragraph,
                   why_work: Faker::Lorem.paragraph,
                   friends_describe: Faker::Lorem.paragraph,
                   strongest_weakest_attributes: Faker::Lorem.paragraph,
                   how_to_deal_challenging_client: Faker::Lorem.paragraph,
                   specialties: Faker::Lorem.paragraph,
                   tools: Faker::Lorem.paragraph,
                   professional_goals: Faker::Lorem.paragraph,
                   how_did_you_hear: 'Friend')

app1.approve!
app2.approve!
# psy2.psychic.update_attributes phone: "+17863295532", about: "Trinity is descended from the Native Americans of the Lakota, Pima, and Navajo Indian tribes. Her psychic gifts have been passed down from generation to generation. An active proponent of her culture, Trinity regularly attends sacred pipe ceremonies and sweat lodges. After her brother's death in a tragic car accident, she became an actualized clairaudient. Determined to help others find closure and heal from unexpected loss, she began reading professionally. Trinity is also a clairvoyant who does not use tools. All she requires is a first name to channel messages from your Spirit Guides. Trinity specializes in love and relationships, and offers insights into diverse and unique interpersonal relationships, including polyamorous connections, among others. Raised with innate abilities, she conveys truthful and accurate messages, but she doesn't sugarcoat the information she receives.",
#   price: 6.5, address: "3044 74th Terrace", city: "Miami", state: "FL",
#   zip_code: "33143", cellular_number: "+13055053030", ssn: "3333333333",
#   date_of_birth: "1988-03-01", us_citizen: true, has_experience: true

csr = User.create!(first_name: 'Carlos', last_name: 'Taborda',
                  username: 'csr', email: 'carlos@carlos.is',
                  password: 'ipass123', create_as: 'csr', confirmed_at: Time.now)

csr.rep.update_attributes phone: "+13054502995"

100.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  begin
    app = PsychicApplication.create!(first_name: first_name,
                               last_name: last_name,
                               username: Faker::Internet.user_name,
                               email: Faker::Internet.email(name: "#{first_name} #{last_name}"),
                               address: Faker::Address.street_address,
                               city: Faker::Address.city,
                               state: Faker::Address.state,
                               zip_code: Faker::Address.zip_code,
                               password: 'ipass123',
                               phone: "+1#{Faker::Base.regexify(/\d{10}/)}",
                               cellular_number: "+1#{Faker::Base.regexify(/\d{10}/)}",
                               ssn: Faker::Base.regexify(/\d{3}-?\d{2}-?\d{4}/),
                               date_of_birth: "1985-01-01",
                               emergency_contact: Faker::Name.name,
                               emergency_contact_number: "+1#{Faker::Base.regexify(/\d{10}/)}",
                               us_citizen: true, has_experience: true,
                               experience: Faker::Lorem.paragraph,
                               gift: Faker::Lorem.words,
                               explain_gift: Faker::Lorem.paragraph,
                               age_discovered: 12,
                               reading_style: Faker::Lorem.paragraph,
                               why_work: Faker::Lorem.paragraph,
                               friends_describe: Faker::Lorem.paragraph,
                               strongest_weakest_attributes: Faker::Lorem.paragraph,
                               how_to_deal_challenging_client: Faker::Lorem.paragraph,
                               specialties: Faker::Lorem.paragraph,
                               tools: Faker::Lorem.paragraph,
                               professional_goals: Faker::Lorem.paragraph,
                               how_did_you_hear: 'Friend')
    app.approve!
  rescue ActiveRecord::RecordInvalid
    p $!.class
    p $!
    # raise $!
  end
end

Psychic.all.each { |p| p.update_attributes price: [4.5, 5.0, 5.5, 6.0, 6.5].sample}

100.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  begin
    user = User.create!(first_name: first_name,
                       last_name: last_name,
                       username: Faker::Internet.user_name,
                       email: Faker::Internet.email(name: "#{first_name} #{last_name}"),
                       phone_number: "+1#{Faker::Base.regexify(/\d{10}/)}",
                       password: 'ipass123', create_as: 'client', confirmed_at: Time.now)

    cli = user.client
    cli.balance = Random.rand(150)
    cli.save!
    # cli = user.client
    # p cli
    # cli.phones.create phone: Faker::PhoneNumber.phone_number
  rescue ActiveRecord::RecordInvalid
    p $!.class
    p $!
    # raise $!
  end
end

now = DateTime.now
period_start = now - now.wday
period_end = period_start - 7.days

200.times do
  psychic = Psychic.first(offset: rand(Psychic.count))
  client  = Client.first(offset: rand(Client.count))
  duration = Random.rand(240)
  original_duration = (duration * 60).to_s

  started_at = Time.at((period_end.to_f - period_start.to_f)*rand + period_start.to_f)
  ended_at = started_at + duration.minutes

  Call.create(client: client, psychic: psychic, original_duration: original_duration,
              started_at: started_at, ended_at: ended_at,
              start_time: started_at.to_s, ended_at: ended_at.to_s,
              cost: duration * psychic.price,
              cost_per_minute: psychic.price,
              processed: true)
end
