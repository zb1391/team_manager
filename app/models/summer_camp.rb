class SummerCamp < ActiveRecord::Base
	attr_accessor :updating_price_internally

	has_many :campifications
	has_many :summer_campers, :through => :campifications

	validates :start_date, :end_date, :end_registration_date,
		presence: {message: 'You must enter a date'}

	validates :price, presence: {message: 'You must enter a price'},
		numericality: {greater_than: 0}

	before_save :update_other_prices, 
		if: Proc.new {|a| SummerCamp.summer_camps_this_year.any?}

	def campers
		self.summer_campers.order(:gender,:grade,:last_name)
	end

	def date_range
		"#{self.start_date.strftime("%b-%d-%y")} - #{self.end_date.strftime("%b-%d-%y")}"
	end

	def date_range_short
		"#{self.start_date.strftime("%b %d")} - #{self.end_date.strftime("%b %d")}"
	end

	def self.active_summer_camps
		SummerCamp.search(end_registration_date_gt: Date.today).result.order(:start_date)
	end
	
	def self.summer_camps_this_year
		cur_year = Date.new(Date.today.year, 1,1)
		SummerCamp.search(start_date_gt: cur_year).result.order(:start_date)
	end

	def self.this_year_price
		camp = SummerCamp.summer_camps_this_year.first
		camp.nil? ? 0 : camp.price
	end

	private
	# all camps this year should have the same price
	def update_other_prices
		summer_camps = SummerCamp.summer_camps_this_year.search(price_not_eq: self.price).result
		summer_camps.each do |summer_camp|
			if summer_camp.price != self.price && updating_price_internally != true
				summer_camp.update_attributes(price: self.price, updating_price_internally: true)
			end
		end
	end
end
