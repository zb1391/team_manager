class Organization < ActiveRecord::Base
	belongs_to :tournament
	has_many :clubs, :dependent => :destroy
	accepts_nested_attributes_for :clubs, :reject_if => lambda { |a| a[:coach].blank? }, allow_destroy: true
	validates :phone, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	validates :name, :contact_name, :email, :phone, presence: true
	validate :atleast_one_club
	before_create :initial_pay_values
	before_create :amount_owe_setup
	def atleast_one_club
		if clubs.empty?
			errors.add(:clubs, "You Must Register at least One Team --- Please click the Add Team button below")
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

end
