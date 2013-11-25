# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create!([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create!(name: 'Emanuel', city: cities.first)

ScheduleJob.create!(description: 'Client Weekly Usage Report',
                    week_day: 'monday',
                    at: '1AM',
                    model: 'ClientWeeklyUsageReport',
                    action: 'deliver')

horoscope = Horoscope.new(date: Date.today)
Horoscope::SIGNS.each do |sign|
  horoscope.send("#{sign.name.downcase}=", Faker::Lorem.paragraphs(3).join("\n"))
end
horoscope.lovescope = Faker::Lorem.paragraphs(3).join("\n")
horoscope.friendship_compatibility_from = Horoscope::SIGNS.sample.name
horoscope.friendship_compatibility_to = Horoscope::SIGNS.sample.name
horoscope.love_compatibility_from = Horoscope::SIGNS.sample.name
horoscope.love_compatibility_to = Horoscope::SIGNS.sample.name
horoscope.save

survey = Survey.create(name: "Client Survey", active: true)

question = survey.questions.create(type: "OptionsQuestion", text: "How often do you have a Psychic reading a month?")
question.options.create(text: "More than 10 times a month")
question.options.create(text: "6 - 10 times a month")
question.options.create(text: "2 - 5 times a month")
question.options.create(text: "Once a month")

question = survey.questions.create(type: "YesNoQuestion", text: "Do you currently use other Psychic services besides I Heart Psychics? ")

question = survey.questions.create(type: "OptionsQuestion", text: "How is your experience with I Heart Psychics versus the other Psychic services you have used?")
question.options.create(text: "Much Better")
question.options.create(text: "Better")
question.options.create(text: "The Same")
question.options.create(text: "Worst")
question.options.create(text: "Not Applicable")

question = survey.questions.create(type: "OptionsQuestion", text: "Based upon your experience with I Heart Psychics, how likely are you to use the service again?")
question.options.create(text: "Definitely Will")
question.options.create(text: "Probably Will")
question.options.create(text: "May or May Not")
question.options.create(text: "Probably Will Not")
question.options.create(text: "Definitely Will Not")

question = survey.questions.create(type: "TextQuestion", text: "Please share a few things that I Heart Psychics could do better to improve your experience:")

Package.create(name: "$32 in credits", credits: 32, price: 30, active: true, phone: true)
Package.create(name: "$55 in credits", credits: 55, price: 50, active: true, phone: true)
Package.create(name: "$10 in credits", credits: 10, price: 5.99, active: true, phone: true)

Tier.create(name: 'Bronze',   from: 0, to: 999, percent: 14)
Tier.create(name: 'Silver',   from: 1000, to: 1199, percent: 19)
Tier.create(name: 'Gold',     from: 1200, to: 1599, percent: 19.5)
Tier.create(name: 'Platinum', from: 1600, to: 1999, percent: 20)
Tier.create(name: 'Diamond',  from: 2000, to: 999999, percent: 21)

cat_general = Category.create(name: "General Questions")
cat_account = Category.create(name: "Account Questions")
cat_psychic = Category.create(name: "Psychic Questions")
cat_csr     = Category.create(name: "Customer Service")
cat_minutes = Category.create(name: "Adding Minutes")
cat_cancel  = Category.create(name: "Canceling Account")
cat_careers = Category.create(name: "Careers")

cat_general.faqs.create(question: "How do I call or chat with a Psychic?", answer: <<-EOS)
Simply select a psychic from the home page listings or browse psychic descriptions by category. If the psychic is available to take calls, you will see a “Call Me” button. If a psychic is available to chat you will see a “Chat Now” button. Click the psychic’s “Call Me” or “Chat Now” button to connect.

If you’re a first-time customer, you will be asked to set up an account before being connected. If you’re an existing customer, you must log in first to be connected with a psychic.
EOS

lorem = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fugiat, dicta, eligendi, tempore sed maiores magni quibusdam libero quam quis ducimus voluptatum odio illum fuga excepturi aperiam totam iste ab temporibus."
cat_general.faqs.create(question: "What if my Psychic isn’t available?", answer: lorem)
cat_general.faqs.create(question: "What kind of question can I ask?", answer: lorem)
cat_general.faqs.create(question: "What if I run out of time during my
reading?", answer: lorem)
cat_general.faqs.create(question: "How will I know when I’m running
out of time?", answer: lorem)
cat_general.faqs.create(question: "Do I have to use my minutes all at
once?", answer: lorem)
cat_general.faqs.create(question: "What if I forget my 10-digit account
number or 4-digit PIN?", answer: lorem)

admin = User.create!(first_name: 'Master', last_name: 'Admin',
                    username: 'admin', email: 'admin@iheartpsychics.co',
                    password: 'ipass123', create_as: 'admin', confirmed_at: Time.now)

wadmin = User.create!(first_name: 'Website', last_name: 'Admin',
                     username: 'wadmin', email: 'wadmin@iheartpsychics.co',
                     password: 'ipass123', create_as: 'website_admin',
                     confirmed_at: Time.now)

mdirector = User.create!(first_name: 'Manager', last_name: 'Director',
                        username: 'mdir', email: 'mdir@iheartpsychics.co',
                        password: 'ipass123', create_as: 'manager_director',
                        confirmed_at: Time.now)

accountant = User.create!(first_name: 'Accountant', last_name: '',
                         username: 'accountant', email: 'accountant@iheartpsychics.co',
                         password: 'ipass123', create_as: 'accountant',
                         confirmed_at: Time.now)

app1 = PsychicApplication.create!(first_name: 'Unfortunate', last_name: 'Teller', pseudonym: 'Ruffus',
                   username: 'ufteller', email: 'ufteller@iheartpsychics.co',
                   address: '3032 47th St', city: 'Lansing', state: 'MI', country: "United States",
                   postal_code: Faker::Address.zip_code,
                   password: 'ipass123', phone: '+17863295532',
                   cellular_number: '+13054502992',
                   date_of_birth: "1985-01-01",
                   emergency_contact: Faker::Name.name,
                   emergency_contact_number: "+13044440404",
                   us_citizen: true, has_experience: true,
                   experience: Faker::Lorem.paragraph,
                   gift: Faker::Lorem.words.join,
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

app2 = PsychicApplication.create!(first_name: 'Trinity', last_name: 'Megan', pseudonym: 'Magus',
                   username: 'tmegan', email: 'trinity@iheartpsychics.co',
                   address: '1022 32nd St', city: 'Miami', state: 'FL', country: "United States",
                   postal_code: Faker::Address.zip_code,
                   password: 'ipass123', phone: '+17863295532',
                   cellular_number: '+13054502993',
                   date_of_birth: "1985-01-01",
                   emergency_contact: Faker::Name.name,
                   emergency_contact_number: "+13044440404",
                   us_citizen: true, has_experience: true,
                   experience: Faker::Lorem.paragraph,
                   gift: Faker::Lorem.words.join,
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
                               pseudonym: Faker::Name.first_name,
                               username: Faker::Internet.user_name,
                               email: Faker::Internet.email(name: "#{first_name} #{last_name}"),
                               address: Faker::Address.street_address,
                               city: Faker::Address.city,
                               state: Faker::Address.state,
                               country: "United States",
                               postal_code: Faker::Address.zip_code,
                               password: 'ipass123',
                               phone: "+1#{Faker::Base.regexify(/\d{10}/)}",
                               cellular_number: "+1#{Faker::Base.regexify(/\d{10}/)}",
                               date_of_birth: "1985-01-01",
                               emergency_contact: Faker::Name.name,
                               emergency_contact_number: "+1#{Faker::Base.regexify(/\d{10}/)}",
                               us_citizen: true, has_experience: true,
                               experience: Faker::Lorem.paragraph,
                               gift: Faker::Lorem.words.join,
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

Psychic.all.each do |p|
  p.update_attributes price: [4.5, 5.0, 5.5, 6.0, 6.5].sample,
    about: Faker::Lorem.paragraphs(3).join("\n")

  (0..(Random.rand(15))).each do |i|
    start_hour = (0..11).to_a.sample
    end_hour = (0..11).to_a.sample
    p.schedules.create(date: Date.today + i, start_time_string: "#{start_hour}:00 AM", end_time_string: "#{end_hour}:00 PM")
    if end_hour < 3
      start_hour = end_hour + Random.rand(3)
      end_hour = start_hour + Random.rand(3)
      p.schedules.create(date: Date.today + i, start_time_string: "#{start_hour}:00 AM", end_time_string: "#{end_hour}:00 PM")
    end
  end
end

user = User.create!(first_name: "Felipe",
                   last_name: "Coury",
                   username: "fcoury",
                   email: "felipe.coury@gmail.com",
                   password: "ipass123",
                   create_as: "client",
                   confirmed_at: Time.now)
client = user.client
client.balance = 250
client.phones.create(number: "+17863295532")

100.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  begin
    user = User.create!(first_name: first_name,
                       last_name: last_name,
                       username: Faker::Internet.user_name,
                       email: Faker::Internet.email(name: "#{first_name} #{last_name}"),
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

psychic = User.find_by_username('tmegan').psychic
psychic.reviews.create(client: Client.first(offset: rand(Client.count)), rating: 5, text: "Amazing experience")
psychic.reviews.create(client: Client.first(offset: rand(Client.count)), rating: 4, text: "Super nice, recommended")

300.times do
  psychic = Psychic.first(offset: rand(Psychic.count))
  psychic.reviews.create(client: Client.first(offset: rand(Client.count)),
                         rating: 4, text: Faker::Lorem.words(10).join)
end

now = DateTime.now
period_start = now - now.wday
period_end = period_start - 7.days

1000.times do
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
              from: client.phones.first.try(:number),
              processed: true)
end
