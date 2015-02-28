class DisplayTournament < ActiveRecord::Base
	has_many :display_tournament_locations, dependent: :destroy
	has_many :locations, through: :display_tournament_locations
	belongs_to :tournament_type

	validates :season, presence:{message: 'You must enter a season'},
		if: Proc.new{|a| a.tournament_type.name == "Invitational"}
	validates :min_grade, presence: {message: 'You must select a min grade'}
	validates :max_grade, presence: {message: 'You must select a max grade'}
	validates :guaranteed_games, presence:{message: 'You must enter a number'}
	validates :price, numericality: {greater_than: 0, message: 'Must be a valid number'}
	validates :genders, presence: {message: 'You must select which genders`'}
	validates_presence_of :display_tournament_locations, message: 'You must select at least one location'
	validate  :grade_range_validation

	accepts_nested_attributes_for :display_tournament_locations,
		allow_destroy: true,
		reject_if: proc {|attributes| attributes['location_id'].blank?}

	before_save :set_display_content

	def display_grades
		"#{self.min_grade}-#{self.max_grade}"
	end

	def display_gender
		try(:genders).try(:downcase) == "both" ? "Boys and Girls" : genders
	end
	
	private
	# max grade should be greater than min grade
	def grade_range_validation
		unless min_grade < max_grade
			errors.add(:min_grade, "Minimum Grade must be smaller than Maximum Grade")
		end
	end

	# set the previous tournament for display content to false
	def set_display_content
		if active
			DisplayTournament.where(active: true, tournament_type_id: self.tournament_type_id).each do |tournament|
				tournament.update_attributes(active: false) unless tournament.id == self.id
			end
		end
	end
end