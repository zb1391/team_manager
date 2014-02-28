class Eventtype < ActiveRecord::Base
	has_many :events

	def formatted_name
		return name.slice(0,1).capitalize + name.slice(1..-1)
	end
end
