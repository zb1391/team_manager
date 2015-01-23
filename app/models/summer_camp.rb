class SummerCamp < ActiveRecord::Base
	has_many :campifications
	has_many :summer_campers, :through => :campifications

	def campers
		self.summer_campers.order(:gender,:grade,:last_name)
	end

	def date_range
		"#{self.start_date.strftime("%b-%d-%y")} --- #{self.end_date.strftime("%b-%d-%y")}"
	end

	def date_range_short
		"#{self.start_date.strftime("%b %d")} - #{self.end_date.strftime("%b %d")}"
	end

	def self.active_summer_camps
		cur_year = Date.new(Date.today.year, 1,1)
		SummerCamp.search(start_date_gt: cur_year).result.order(:start_date)
	end
end
