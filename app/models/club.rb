class Club < ActiveRecord::Base
	attr_accessor :use_organization_info
	belongs_to :organization
	validates :coach, presence: {message: 'You must enter a coach name'}
	validates :email, presence: {message: 'You muster enter a coach email'}
	validates :cell, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	def team_name
		"#{gender} #{grade} Grade"
	end

	def paypal_encrypted(return_url, notify_url)
	  values = {
	    :business => 'gymratzaau@gmail.com',
	    :cmd => '_cart',
	    :upload => 1,
	    :invoice => organization.id,
	    :return => return_url,
	    :notify_url => notify_url,
	    :cert_id => "6D298L4MSEB2A",
	    :amount_1 => organization.tournament.price,
	    :item_name_1 => self.team_name,
	    :item_number_1 => self.id,
	    :quantity_1 => '1'
	  }
	  encrypt_for_paypal(values)
	end

	PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
	APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")
	APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")

	def encrypt_for_paypal(values)
	  signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
	  OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
	end
end
