class SummerCamp < ActiveRecord::Base
	has_many :campifications
	has_many :summer_campers, :through => :campifications

	def campers
		self.summer_campers.order(:gender,:grade,:last_name)
	end

	def date_range
		"#{self.start_date.strftime("%b-%d-%y")} --- #{self.end_date.strftime("%b-%d-%y")}"
	end
end
