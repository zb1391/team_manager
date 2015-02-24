class Hotel < ActiveRecord::Base
	has_many :hotelifications
	has_many :events, :through => :hotelifications
	validates :address, presence: {message: 'You must enter an address'}
	validates :city, presence: {message: 'You must enter a city'}
	validates :state, presence: {message: 'You must enter a state'}
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :phone, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	validates :name, presence: {message: 'You must enter a name'}
	def name_and_date
		if start_date.nil?
			"#{name}"
		else
			"#{name} - #{start_date.strftime("%b-%d-%y")}"
		end
	end
	def glocation
		gaddress = ""+"#{address}"
		gcity = ""+"#{city}"
		gstate =""+"#{state}"
		if gaddress.include? ' '
			gaddress=gaddress.gsub!(' ','+')
		end
		if gcity.include? ' '
			gcity=gcity.gsub!(' ','+')
		end
		if gstate.include? ' '
			gstate=gstate.gsub!(' ','+')
		end
		return "#{gaddress},#{gcity},#{gstate}"
	end
	def full_address
		"#{address}, #{city}, #{state}"
	end

	def directions
		"https://maps.google.com/maps?f=d&daddr=#{glocation}"
	end

	def formatted_price
		newprice = number_to_currency(price)
		"#{newprice}/night"
	end

	def collection_format
		"#{name}-#{full_address}"
	end

	def hotel_link
		/^http/i.match(addtional_link) ? addtional_link : "http://#{addtional_link}"
	end
end
