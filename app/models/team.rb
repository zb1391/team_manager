require 'digest'

class Team < ActiveRecord::Base
	attr_accessor :password 
	has_many :players
	has_many :events
	belongs_to :coach
	validates :password, :confirmation => true, :presence => true, :length => {:within => 6..40}, :on => :create
	validate :check_for_team
	before_create :encrypt_password #before we save the row to the database, we will encrypt the password
	before_save :name_setup
	def check_for_team
		already_a_row = Team.where("gender = ? AND grade = ? AND team_type = ?",gender,grade,team_type).to_a
		if !already_a_row.empty?
			if already_a_row[0].my_id != my_id
				errors.add(:name, "team already exists")
			end
		end
	end

	def short_team_name
		"#{gender} #{grade} Grade #{team_type}"
	end

	def dropdown_name
		"#{grade} Grade #{gender} #{team_type}"
	end

	#return an array of all teams of Gender g
	def self.all_teams_of_gender(g)
		Team.where("gender = ?",g).order(:id).to_a
	end

	def self.all_teams_of_gender_and_type(g,t)
		Team.where("gender = ? AND team_type = ?",g,t).order(:id)
	end

	def my_id 
		return id
	end
	#return true if the user's password matches the submitted password
	def has_password?(submitted_password)
		#compare encrypted_password with the encrypted version of the submitted password
		encrypted_password == encrypt(submitted_password)

	end

	#Return all teams by gender
	def self.teams_by_gender(gender)
		Team.where("gender = ?", gender).to_a
	end


	def self.authenticate(email,submitted_password)
		team = find_by_teamname(teamname)
		return nil if team.nil?
		return team if team.has_password?(submitted_password)
	end

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << Player.column_names
			players.each do |player|
				csv << player.attributes.values_at(*Player.column_names)
			end
		end
	end

	private
		def name_setup
			self.name = namemake("#{grade} Grade #{gender} #{team_type}")
		end

		def encrypt_password
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(self.password)
		end

		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end

		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end

		def namemake(string)
			string
		end

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end

end
