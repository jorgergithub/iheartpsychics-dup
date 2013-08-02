# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create(first_name: 'Website', last_name: 'Admin',
                    username: 'admin', email: 'admin@iheartpsychics.co',
                    password: 'ipass123', create_as: 'admin', confirmed_at: Time.now)

psy1 = User.create(first_name: 'Unfortunate', last_name: 'Teller',
                   username: 'ufteller', email: 'ufteller@iheartpsychics.co',
                   password: 'ipass123', create_as: 'psychic', confirmed_at: Time.now)

psy2 = User.create(first_name: 'Carlos', last_name: 'Taborda',
                   username: 'ctaborda', email: 'ctaborda@iheartpsychics.co',
                   password: 'ipass123', create_as: 'psychic', confirmed_at: Time.now)

psy2.psychic.update_attributes phone: "+13054502995"

csr = User.create(first_name: 'Carlos', last_name: 'Taborda',
                  username: 'csr', email: 'carlos@carlos.is',
                  password: 'ipass123', create_as: 'csr', confirmed_at: Time.now)

csr.rep.update_attributes phone: "+13054502995"
