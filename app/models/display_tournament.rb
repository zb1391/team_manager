class DisplayTournament < ActiveRecord::Base
	has_many :display_tournament_locations
	has_many :locations, through: :display_tournament_locations

	validates :season, presence:{message: 'You must enter a season'}
	validates :min_grade, presence: {message: 'You must select a min grade'}
	validates :max_grade, presence: {message: 'You must select a max grade'}
	validates :guaranteed_games, presence:{message: 'You must enter a number'}
	validates :price, numericality: {greater_than: 0, message: 'Must be a valid number'}
	validates :genders, presence: {message: 'You must select which genders`'}
	validates_presence_of :display_tournament_locations, message: 'You must select at least one location'

	accepts_nested_attributes_for :display_tournament_locations,
		allow_destroy: true,
		reject_if: proc {|attributes| attributes['location_id'].blank?}

	before_save :set_display_content

	def display_grades
		"#{self.min_grade}-#{self.max_grade}"
	end

	def display_gender
		genders.downcase == "both" ? "Boys and Girls" : gender
	end
	private
	# set the previous tournament for display content to false
	def set_display_content
		if active
			DisplayTournament.where(active: true).each do |tournament|
				tournament.update_attributes(active: false)
			end
		end
	end
end