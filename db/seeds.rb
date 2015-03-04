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
#ADD ALL COACHES
	#ADMINS

	danny = Coach.create!(needs_encryption: true, first_name: "Danny", last_name: "Brown", email: "dbrown@downtownsports.org", phone: "2013411959",
		password: ENV['db_password'], password_confirmation: ENV['db_password'])
	danny.toggle!(:admin)
	adam = Coach.create!(needs_encryption: true, first_name: "Adam", last_name: "Brown", email: "abrown@downtownsports.org", phone: "5853038053",
		password: ENV['ab_password'], password_confirmation: ENV['ab_password'])
	adam.toggle!(:admin)
	zac = Coach.create!(needs_encryption: true, first_name: "Zac", last_name: "Brown", email: "zmb1391@gmail.com", phone: "2018350411",
		password: ENV['zb_password'], password_confirmation: ENV['zb_password'])
	zac.toggle!(:admin)

	#ALL OTHER COACHES
		Coach.create(first_name: "Donald", last_name: "Osbourne", email: "coachozzie34@aol.com", phone: "2018517504")

		Coach.create(first_name: "Billy", last_name: "Downes", email: "bmka90@yahoo.com", phone: "8455362116")

		Coach.create(first_name: "Brad", last_name: "Allen", email: "bradockallen@hotmail.com", phone: "4047844778")

		Coach.create(first_name: "Anthony", last_name: "Gallo", email: "agallo0523@gmail.com", phone: "2017247515")

		Coach.create(first_name: "Jevon", last_name: "Drakeford", email: "drakefordjevon@gmail.com", phone: "2018732630")

		Coach.create(first_name: "Nate", last_name: "Seabrook", email: "coachnate5@yahoo.com", phone: "2019230722")

		Coach.create(first_name: "Megan", last_name: "Thomas", email: "lo.thomas10@yahoo.com", phone: "2019516804")

be3 = Team.create(gender: "Boys", grade:"3", team_type:"Elite", password:"*gratzb3e", password_confirmation:"*gratzb3e")
be4 = Team.create(gender: "Boys", grade:"4", team_type:"Elite", password:"*gratzb4e", password_confirmation:"*gratzb4e")
be5 = Team.create(gender: "Boys", grade:"5", team_type:"Elite", password:"*gratzb5e", password_confirmation:"*gratzb5e")
be6 = Team.create(gender: "Boys", grade:"6", team_type:"Elite", password:"*gratzb6e", password_confirmation:"*gratzb6e")
be7 = Team.create(gender: "Boys", grade:"7", team_type:"Elite", password:"*gratzb7e", password_confirmation:"*gratzb7e")
be8 = Team.create(gender: "Boys", grade:"8", team_type:"Elite", password:"*gratzb8e", password_confirmation:"*gratzb8e")
be9 = Team.create(gender: "Boys", grade:"9", team_type:"Elite", password:"*gratzb9e", password_confirmation:"*gratzb9e")
be10 = Team.create(gender: "Boys", grade:"10", team_type:"Elite", password:"*gratzb10e", password_confirmation:"*gratzb10e")
be11 = Team.create(gender: "Boys", grade:"11", team_type:"Elite", password:"*gratzb11e", password_confirmation:"*gratzb11e")
be12 = Team.create(gender: "Boys", grade:"12", team_type:"Elite", password:"*gratzb12e", password_confirmation:"*gratzb12e")
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


ge3 = Team.create(gender: "Girls", grade:"3", team_type:"Elite", password:"*gratzg3e", password_confirmation:"*gratzg3e")
ge4 = Team.create(gender: "Girls", grade:"4", team_type:"Elite", password:"*gratzg4e", password_confirmation:"*gratzg4e")
ge5 = Team.create(gender: "Girls", grade:"5", team_type:"Elite", password:"*gratzg5e", password_confirmation:"*gratzg5e")
ge6 = Team.create(gender: "Girls", grade:"6", team_type:"Elite", password:"*gratzg6e", password_confirmation:"*gratzg6e")
ge7 = Team.create(gender: "Girls", grade:"7", team_type:"Elite", password:"*gratzg7e", password_confirmation:"*gratzg7e")
ge8 = Team.create(gender: "Girls", grade:"8", team_type:"Elite", password:"*gratzg8e", password_confirmation:"*gratzg8e")
ge9 = Team.create(gender: "Girls", grade:"9", team_type:"Elite", password:"*gratzg9e", password_confirmation:"*gratzg9e")
ge10 = Team.create(gender: "Girls", grade:"10", team_type:"Elite", password:"*gratzg10e", password_confirmation:"*gratzg10e")
ge11 = Team.create(gender: "Girls", grade:"11", team_type:"Elite", password:"*gratzg11e", password_confirmation:"*gratzg11e")
ge12 = Team.create(gender: "Girls", grade:"12", team_type:"Elite", password:"*gratzg12e", password_confirmation:"*gratzg12e")
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


practice = Eventtype.create(name: "practice")
game = Eventtype.create(name: "game")
tournament = Eventtype.create(name: "tournament")

dts = Location.create(name: "Down Town Sports", address: "7 Leighton Place", city: "Mahwah",state: "NJ")
srds = Location.create(name: "Saddle River Day", address: "147 Chestnut Ridge Rd", city: "Saddle River", state: "NJ")

# Home Page Panels
panel1 = HomePagePanel.create!(is_active: true, title: "Welcome to Down Town Sports", priority_order: 1,
	html: "<p id=\"paragraph\">Down Town Sports a new State of the Art Basketball/Sports Facility. The gym is open year-round and is one of its kind in Bergen County. With two full hardwood regulation courts, the facility is designed to accommodate a wide variety of sports and programs for kids and adults to enjoy.</p><dl></dl>")
panel2 = HomePagePanel.create!(is_active: true, title: "Gym Ratz AAU Spring Tryouts", priority_order: 2,
	html: "<p id=\"paragraph\">Join Us For Spring AAU Tryouts. We offer a program for serious players to develop team skill and maximize individual potentialthrough structured practices, games and tournament competition</p><dl></dl>")
panel3 = HomePagePanel.create!(is_active: true, title: "Training That Suits You", priority_order: 3,
	html: "<p id=\"paragraph\">Our goal is to help our players be the best that they can be. We offer a wide variety of training programs appropriate for every skill level including private One-On-One lessons and group clinics.</p><dl></dl>")

# Tournament Types
TournamentType.create!(name: 'Invitational')
TournamentType.create!(name: 'One Day Shootout')
TournamentType.create!(name: 'Other')