class TryoutTime < ActiveRecord::Base
	belongs_to :tryout_date
	
	has_many :team_tryout_times
	has_many :teams, through: :team_tryout_times

	accepts_nested_attributes_for :team_tryout_times

	def team_grades(gender)
		"#{gender} #{teams.where(gender: gender).collect{|team| team.grade}.join(", ")} Grade"
	end
end