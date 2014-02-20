class Player < ActiveRecord::Base
	attr_accessor :password
	belongs_to :team

	validates :first_name, :last_name, :phone, :email, presence: true
	validates :phone, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	validate :password_matches_team


	def password_matches_team
		team = Team.find(team_id)
		if team.nil?
			errors.add(:password, "invalid team find")
		end
		if !team.has_password?(password)
			errors.add(:password, "invalid team password")
		end
	end

end

