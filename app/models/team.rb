require 'digest'

class Team < ActiveRecord::Base
	attr_accessor :password 
	attr_accessor :color
	attr_accessor :should_validate_password
	has_many :players
	has_many :events
	has_many :tryout_times
	has_one :home_page_file, dependent: :destroy
	accepts_nested_attributes_for :home_page_file, reject_if: :all_blank

	belongs_to :coach
	# validate :unique_name
	validates :name, uniqueness: {message: 'A team with this name already exists'}
	validates :password, :confirmation => true, :presence => true, :length => {:within => 6..40}, 
		unless: Proc.new {|a| a.should_validate_password.nil?}
	before_save :encrypt_password #before we save the row to the database, we will encrypt the password
	before_validation :name_setup
	before_save :age_setup


	scope :boys, -> {where(gender: "Boys").order(:grade)}
	scope :elite_teams, -> {where(team_type: 'Elite').order(:gender, :grade)}
	scope :select_teams, ->{where(team_type: 'Select').order(:gender, :grade)}
	scope :girls, -> {where(gender: 'Girls').order(:grade)}

	def short_team_name
		"#{gender} #{grade.ordinalize} Grade #{team_type}"
	end

	def dropdown_name
		"#{grade.ordinalize} Grade #{gender} #{team_type}"
	end

	def team_color
		if name.nil?
			return nil
		else	
			array = name.strip.split(/\s+/).to_a
			color = array[-1]
			if color == "Elite" || color == "Select"
				return nil
			else
				return color
			end
		end
	end

	def tournaments
		Event.search(:eventtype_name_cont => "tournament", :team_id_eq => my_id).result.order(:the_date).to_a
	end

	#return an array of all teams of Gender g
	def self.all_teams_of_gender(g)
		Team.where("gender = ?",g).order(:id).to_a
	end

	def self.all_teams_of_gender_and_type(g,t)
		Team.where("gender = ? AND team_type = ?",g,t).order(:age)
	end

	def my_number
		grade
	end
	def my_id 
		return id
	end
	#return true if the user's password matches the submitted password
	def has_password?(submitted_password)
		#compare encrypted_password with the encrypted version of the submitted password
		encrypted_password == encrypt(submitted_password)

	end

	#Return all of todays events
	def todays_events
		Event.search(:the_date_eq => Date.today.to_s, :team_id_eq => my_id).result.order(:the_time).to_a
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
		def unique_name
			if Team.where(name: self.name).any?
				errors.add(:name, "A team with this name already exists")
				return false
			end
		end
		def age_setup
			self.age = get_age(grade)
		end
		def name_setup
			if color.blank?
				self.name = namemake("#{grade.ordinalize} Grade #{gender} #{team_type}")
			else

				self.name = namemake("#{grade.ordinalize} Grade #{gender} #{team_type} #{color}")
			end
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

		def get_age(grade)
			grade
		end

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end

end
