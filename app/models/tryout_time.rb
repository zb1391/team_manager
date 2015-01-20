class TryoutTime < ActiveRecord::Base
	belongs_to :tryout_date
	
	has_many :team_tryout_times, dependent: :destroy
	has_many :teams, through: :team_tryout_times

	accepts_nested_attributes_for :team_tryout_times, allow_destroy: true

	validates_presence_of :team_tryout_times, message: "You must enter at least one team"
	validates :time, presence: {message: "You must enter a time"}
	def team_grades(gender)
		"#{gender} #{teams.where(gender: gender).order(:grade).collect{|team| team.grade}.join(", ")} Grade"
	end
end