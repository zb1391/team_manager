class Tournament < ActiveRecord::Base
	has_many :organizations, :dependent => :destroy

	validates :name, presence:{message: 'You must enter a name'}, unless: "self.is_invitational"
	validates :the_date, presence:{message: 'You must enter a date'}
	validates :price, presence: {message: 'You must enter a price'}, 
										numericality: {greater_than: 0}
	validates_presence_of :tournament_locations, message: 'You must select at least one location'
	validate :tournament_date_validation


	def age_range
		"#{self.min_grade}-#{self.max_grade}"
	end

	def tournament_teams
		Club.search(:organization_tournament_id_eq => id).result.order(:gender,:grade).to_a
	end

	def gender_select
		if genders.downcase == "both"
			return %w[Boys Girls]
		else
			return ["#{self.genders}"]
		end
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

	def display_date
		if end_date.blank?
			"#{the_date.strftime("%b %d")}"
		else
			"#{the_date.strftime("%b %d")} - #{end_date.strftime("%b %d")}"
		end
	end

	def self.find_active_invitationals
		Tournament.search(is_invitational_eq: true, the_date_gt: Date.today).result.order(:the_date)
	end
	def self.find_active_tournaments
		Tournament.search(:the_date_gt => Date.today).result.order(:the_date)
	end
	def self.find_tournaments(name)
		Tournament.search(:name_cont => "#{name}", :the_date_gt => DateTime.now, :active_eq => true).result.order(:the_date).to_a
	end

	def self.find_tournament_id(name)
		array = Tournament.where("name = ?", name).to_a
		return array[0].id
	end

	private

	def tournament_date_validation
		unless end_date.blank?
			if the_date > end_date
				errors.add(:the_date, 'Start Date cannot be after End Date')
			end
		end
	end
end
