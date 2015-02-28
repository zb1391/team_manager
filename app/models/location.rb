class Location < ActiveRecord::Base
	has_many :events
	validates :address, presence: {message: 'You must enter an address'}
	validates :city, presence: {message: 'You must enter a city'}
	validates :name, presence: {message: 'You must enter a name'}
	before_destroy :check_for_events

	def check_for_events
		unless events.empty?
			return false
		end
	end
	
	def name_and_city
		"#{name}, #{city}"
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
	def location_link
		/^http/i.match(additional_link) ? additional_link : "http://#{additional_link}"
	end
end
