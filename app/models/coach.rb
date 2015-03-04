require 'digest'
class Coach < ActiveRecord::Base

	has_many :teams
	
	attr_accessor :password, :needs_encryption
	validates :password, :confirmation => true, :presence => true, :length => {:within => 6..40},
		if: Proc.new {|a| a.admin == true}
	validates :first_name, :last_name, :phone, :email, presence: true
	validates :phone, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	before_save :encrypt_password, :if => :needs_encryption #before we save the row to the database, we will encrypt the password
	before_destroy :check_for_teams #before deleting make sure hes not running any teams

	#return true if the user's password matches the submitted password
	def has_password?(submitted_password)
		#compare encrypted_password with the encrypted version of the submitted password
		encrypted_password == encrypt(submitted_password)

	end

	def last_first_name
		"#{last_name}, #{first_name}"
	end
	def self.authenticate(email,submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end

	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end

	def check_for_teams
		unless teams.empty?
			return false
		end
	end

	def split_email
		email.split('@',2)
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
