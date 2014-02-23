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
adam = Coach.create(first_name: "Adam", last_name: "Brown", email: "abrown@downtownsports.org", phone: "2013411959",
	password: "abrown", password_confirmation: "abrown")
adam.toggle!(:admin)

eventtypes = Eventtype.create([{name: "practice"}, {name: "game"}, {name: "tournament"}])

Location.create(name: "Down Town Sports", address: "7 Leighton Place", city: "Mahwah",state: "NJ")
Location.create(name: "Saddle River Day", address: "147 Chestnut Ridge Rd", city: "Saddle River", state: "NJ")