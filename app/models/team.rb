class Team < ActiveRecord::Base
	has_many :players
	has_many :events

	attr_accessor :password 
	validates :password, :confirmation => true, :presence => true, :length => {:within => 6..40}

	before_save :encrypt_password #before we save the row to the database, we will encrypt the password

	#return true if the user's password matches the submitted password
	def has_password?(submitted_password)
		#compare encrypted_password with the encrypted version of the submitted password
		encrypted_password == encrypt(submitted_password)

	end

	def self.authenticate(email,submitted_password)
		team = find_by_teamname(teamname)
		return nil if team.nil?
		return team if team.has_password?(submitted_password)
	end

	private
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

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
