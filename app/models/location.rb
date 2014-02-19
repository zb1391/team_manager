class Location < ActiveRecord::Base
	has_many :events
	validates :address, :city, :state, presence: true

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
end
