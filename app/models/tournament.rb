class Tournament < ActiveRecord::Base
	has_many :organizations, :dependent => :destroy
	validates :name, :the_date, :price, presence: true


	def tournament_teams
		Club.search(:organization_tournament_id_eq => id).result.order(:gender,:grade).to_a
	end

	def formatted_date
		the_date.strftime("%b-%d-%y")
	end

	def formatted_name
		if end_date.blank?
			"#{name}: #{the_date.strftime("%b %d,%Y")}"
		else
			"#{name}: #{the_date.strftime("%b %d,%Y")} -#{end_date.strftime("%b %d,%Y")}"
		end
	end

	def self.find_one_day_shootouts
		Tournament.search(:name_cont => "One Day", :the_date_gt => DateTime.now).result.to_a
	end

	def self.find_tournament_id(name)
		array = Tournament.where("name = ?", name).to_a
		return array[0].id
	end
end
