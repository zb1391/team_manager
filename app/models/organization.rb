class Organization < ActiveRecord::Base
	attr_accessor :manual_fee_entry
	belongs_to :tournament
	has_many :clubs, :dependent => :destroy
	accepts_nested_attributes_for :clubs, allow_destroy: true
	
	validates :name, presence:{message: 'You must enter a club name'}
	validates :contact_name, presence:{message: 'You must enter a contact name'} 
	validates :email, presence:{message: 'You must enter an email'}
	validates :phone, presence: {message: 'You must enter a phone number'}
	validate :atleast_one_club
	validate :club_in_tournament_range
	validates :phone, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	
	before_create :initial_pay_values

	def atleast_one_club
		if clubs.empty?
			errors.add(:clubs, "You Must Register at least One Team ")
		end
	end

	def paypal_encrypted(return_url, notify_url)
	  values = {
	    :business => 'gymratzaau@gmail.com',
	    :cmd => '_cart',
	    :upload => 1,
	    :invoice => self.id,
	    :return => return_url,
	    :notify_url => notify_url,
	    :cert_id => "6D298L4MSEB2A"
	  }
	  clubs.each_with_index do |item, index|
	    values.merge!({
	      "amount_#{index+1}" => tournament.price,
	      "item_name_#{index+1}" => item.team_name,
	      "item_number_#{index+1}" => item.id,
	      "quantity_#{index+1}" => '1'
	    })
	  end
	  encrypt_for_paypal(values)
	end

	PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
	APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")
	APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")

	def encrypt_for_paypal(values)
	  signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
	  OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
	end

	private

	def initial_pay_values
		if self.amount_paid.nil?
			self.amount_paid = 0
		end
	end

	def amount_owe_setup
		self.amount_owe = tournament.price*clubs.size
	end

	def check_for_manual
		if manual_fee_entry == false
			update_attribute(:amount_owe, tournament.price*clubs.size)
		end

	end

	def club_in_tournament_range
		clubs.each do |club|
			unless tournament.gender_select.include?(club.gender)
				club.errors.add(:team, "This tournament is only for #{tournament.genders}")
			end
			unless tournament.grade_select.include?(club.grade)
				club.errors.add(:team,"This tournament only allows grades #{tournament.age_range}")
			end
		end
	end

end
