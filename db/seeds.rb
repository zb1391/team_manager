# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'

  # MySQL and PostgreSQL
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
end

danny = Coach.create(first_name: "Danny", last_name: "Brown", email: "dbrown@downtownsports.org", phone: "2013411959",
	password: "dbrown", password_confirmation: "dbrown")
danny.toggle!(:admin)
adam = Coach.create(first_name: "Adam", last_name: "Brown", email: "abrown@downtownsports.org", phone: "5853038053",
	password: "abrown", password_confirmation: "abrown")
adam.toggle!(:admin)
zac = Coach.create(first_name: "Zac", last_name: "Brown", email: "zmb1391@gmail.com", phone: "2018350411",
	password: "**ph0335", password_confirmation: "**ph0335")
zac.toggle!(:admin)
eventtypes = Eventtype.create([{name: "practice"}, {name: "game"}, {name: "tournament"}])

be3 = Team.create(gender: "Boys", grade:"3rd", team_type:"Elite", password:"*gratzb3e", password_confirmation:"*gratzb3e")
be4 = Team.create(gender: "Boys", grade:"4th", team_type:"Elite", password:"*gratzb4e", password_confirmation:"*gratzb4e")
be5 = Team.create(gender: "Boys", grade:"5th", team_type:"Elite", password:"*gratzb5e", password_confirmation:"*gratzb5e")
be6 = Team.create(gender: "Boys", grade:"6th", team_type:"Elite", password:"*gratzb6e", password_confirmation:"*gratzb6e")
be7 = Team.create(gender: "Boys", grade:"7th", team_type:"Elite", password:"*gratzb7e", password_confirmation:"*gratzb7e")
be8 = Team.create(gender: "Boys", grade:"8th", team_type:"Elite", password:"*gratzb8e", password_confirmation:"*gratzb8e")
be9 = Team.create(gender: "Boys", grade:"9th", team_type:"Elite", password:"*gratzb9e", password_confirmation:"*gratzb9e")
be10 = Team.create(gender: "Boys", grade:"10th", team_type:"Elite", password:"*gratzb10e", password_confirmation:"*gratzb10e")
be11 = Team.create(gender: "Boys", grade:"11th", team_type:"Elite", password:"*gratzb11e", password_confirmation:"*gratzb11e")
be12 = Team.create(gender: "Boys", grade:"12th", team_type:"Elite", password:"*gratzb12e", password_confirmation:"*gratzb12e")
adam.teams<<be3
adam.teams<<be4
adam.teams<<be5
adam.teams<<be6
adam.teams<<be7
adam.teams<<be8
adam.teams<<be9
adam.teams<<be10
adam.teams<<be11
adam.teams<<be12


ge3 = Team.create(gender: "Girls", grade:"3rd", team_type:"Elite", password:"*gratzg3e", password_confirmation:"*gratzg3e")
ge4 = Team.create(gender: "Girls", grade:"4th", team_type:"Elite", password:"*gratzg4e", password_confirmation:"*gratzg4e")
ge5 = Team.create(gender: "Girls", grade:"5th", team_type:"Elite", password:"*gratzg5e", password_confirmation:"*gratzg5e")
ge6 = Team.create(gender: "Girls", grade:"6th", team_type:"Elite", password:"*gratzg6e", password_confirmation:"*gratzg6e")
ge7 = Team.create(gender: "Girls", grade:"7th", team_type:"Elite", password:"*gratzg7e", password_confirmation:"*gratzg7e")
ge8 = Team.create(gender: "Girls", grade:"8th", team_type:"Elite", password:"*gratzg8e", password_confirmation:"*gratzg8e")
ge9 = Team.create(gender: "Girls", grade:"9th", team_type:"Elite", password:"*gratzg9e", password_confirmation:"*gratzg9e")
ge10 = Team.create(gender: "Girls", grade:"10th", team_type:"Elite", password:"*gratzg10e", password_confirmation:"*gratzg10e")
ge11 = Team.create(gender: "Girls", grade:"11th", team_type:"Elite", password:"*gratzg11e", password_confirmation:"*gratzg11e")
ge12 = Team.create(gender: "Girls", grade:"12th", team_type:"Elite", password:"*gratzg12e", password_confirmation:"*gratzg12e")
danny.teams<<ge3
danny.teams<<ge4
danny.teams<<ge5
danny.teams<<ge6
danny.teams<<ge7
danny.teams<<ge8
danny.teams<<ge9
danny.teams<<ge10
danny.teams<<ge11
danny.teams<<ge12



Location.create(name: "Down Town Sports", address: "7 Leighton Place", city: "Mahwah",state: "NJ")
Location.create(name: "Saddle River Day", address: "147 Chestnut Ridge Rd", city: "Saddle River", state: "NJ")