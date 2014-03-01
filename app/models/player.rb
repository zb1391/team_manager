class Player < ActiveRecord::Base
	attr_accessor :password
	belongs_to :team

	validates :first_name, :last_name, :phone, :email,
		 :parent_first_name,:parent_last_name,:parent_email,:parent_cell,
		 :uniform_number, :emergency_phone,presence: true
	validates :phone, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	validates :parent_cell, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	validates :emergency_phone, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	validate :password_matches_team
	validate :valid_uniform_number, :on => :create

	def password_matches_team
		team = Team.find(team_id)
		if team.nil?
			errors.add(:password, "invalid team find")
		end
		if !team.has_password?(password)
			errors.add(:password, "invalid team password")
		end
	end

	def formatted_name
		last = last_name.slice(0,1).capitalize + last_name.slice(1..-1)
		first = first_name.slice(0,1).capitalize + first_name.slice(1..-1)
		return "#{last}, #{first}"
	end

	#No Player can have a uniform number with any digit > 5
	#Therefore the highest number a player can have is 55
	#This also confirms that the number is unique to the team
	def valid_uniform_number
		ones_digit = uniform_number % 10
		if ones_digit == 0
			ones_digit =1;
		end
		number = Team.search(:id_eq => team_id, :players_uniform_number_eq => uniform_number).result.to_a
		if !number.empty?
			errors.add(:uniform_number, "is already taken")
		end
		if uniform_number <= -1
			errors.add(:uniform_number, "can't be negative")
		end
		if uniform_number > 55
			errors.add(:uniform_number, "can't be greater than 55")
		end

		if 5 % ones_digit == 5
			errors.add(:uniform_number, "c- AAU Regulation no digit greter than 5 (use numbers 0-5,10-15,20-25...)")
		end
	end

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |player|
				csv << player.attributes.values_at(*column_names)
			end
		end
	end

end

