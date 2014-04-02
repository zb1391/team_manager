class Hotel < ActiveRecord::Base
	has_many :hotelifications
	has_many :events, :through => :hotelifications
	validates :price, :address, :city, :state, :phone, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :phone, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}

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
	def unformatted_location
		"#{address},#{city},#{state}"
	end
	def directions
		"https://maps.google.com/maps?f=d&daddr=#{glocation}"
	end

	def formatted_price
		newprice = number_to_currency(price)
		"#{newprice}/night"
	end

	def collection_format
		"#{name}-#{unformatted_location}"
	end
end
