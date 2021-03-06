class Tournament < ActiveRecord::Base
	has_many :organizations, :dependent => :destroy
	has_many :tournament_locations, dependent: :destroy
	has_many :locations, through: :tournament_locations
	belongs_to :tournament_type
	validates_presence_of :tournament_type, message: 'You must choose a tournament type'
	validates :name, presence:{message: 'You must enter a name'},
		unless: Proc.new{|a| a.tournament_type.name != "Other"}
	validates :the_date, presence:{message: 'You must enter a date'}
	validates :price, presence: {message: 'You must enter a price'}, 
										numericality: {greater_than: 0}
	validates_presence_of :tournament_locations, message: 'You must select at least one location'
	validate :tournament_date_validation
	validates :end_registration_date, presence: {message: 'You must enter a date'}
	accepts_nested_attributes_for :tournament_locations, allow_destroy: true, reject_if: :all_blank
	before_save :set_name

	def self.active_tournaments
		where('end_registration_date >= ?', Date.today).order(:the_date)
	end

	def is_invitational
		self.tournament_type.name == "Invitational"
	end

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

	def display_grades
		"#{self.min_grade}-#{self.max_grade}"
	end

	def display_gender
		try(:genders).try(:downcase) == "both" ? "Boys and Girls" : genders
	end

	def gender_and_grade
		"#{display_gender} Grades #{display_grades}"
	end

	def formatted_date
		the_date.strftime("%b-%d-%y")
	end

	def formatted_name
		tournament_name = name
		if end_date.blank?
			"#{tournament_name}: #{the_date.strftime("%b %d")}"
		else
			"#{tournament_name}: #{the_date.strftime("%b %d")} - #{end_date.strftime("%b %d")}"
		end
	end

	def display_date
		if end_date.blank?
			"#{the_date.strftime("%b %d")}"
		else
			"#{the_date.strftime("%b %d")} - #{end_date.strftime("%b %d")}"
		end
	end


	def self.find_tournaments(name)
		Tournament.search(:name_cont => "#{name}", :the_date_gt => DateTime.now, :active_eq => true).result.order(:the_date).to_a
	end

	def self.find_tournament_id(name)
		array = Tournament.where("name = ?", name).to_a
		return array[0].id
	end

	private

	def set_name
		if tournament_type.name == "Invitational"
			self.name = "Gym Ratz Invitational"
		elsif tournament_type.name = "One Day Shootout"
			self.name = "One Day Shootout"
		end
	end
	def tournament_date_validation
		unless end_date.blank?
			if the_date > end_date
				errors.add(:the_date, 'Start Date cannot be after End Date')
			end
		end
	end
end
