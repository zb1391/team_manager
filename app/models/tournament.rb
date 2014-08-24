class Tournament < ActiveRecord::Base
	has_many :organizations, :dependent => :destroy
	validates :name, :the_date, :price, presence: true

	def age_range
		"#{self.min_grade}-#{self.max_grade}"
	end
	def tournament_teams
		Club.search(:organization_tournament_id_eq => id).result.order(:gender,:grade).to_a
	end

	def gender_select
		if genders.downcase == "both"
			puts "inside here"
			return %w[Boys Girls]
		else
			return ["#{self.genders}"]
		end
		puts "right here!"
	end

	def grade_select
		(self.min_grade..self.max_grade).map{|x| "#{x.ordinalize}"}
	end


	def formatted_date
		the_date.strftime("%b-%d-%y")
	end

	def formatted_name
		if end_date.blank?
			"#{name}: #{the_date.strftime("%b %d")}"
		else
			"#{name}: #{the_date.strftime("%b %d")} - #{end_date.strftime("%b %d")}"
		end
	end
	def self.find_active_tournaments
		Tournament.search(:active_eq => true).result.order(:the_date).to_a
	end
	def self.find_tournaments(name)
		Tournament.search(:name_cont => "#{name}", :the_date_gt => DateTime.now, :active_eq => true).result.order(:the_date).to_a
	end

	def self.find_tournament_id(name)
		array = Tournament.where("name = ?", name).to_a
		return array[0].id
	end
end
