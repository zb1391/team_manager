class Event < ActiveRecord::Base
	belongs_to :team
	belongs_to :eventtype

	validates :event_location, :the_date, :the_time, presence: true
	def start_time
		DateTime.new(the_date.year, the_date.month, the_date.day, the_time.hour, the_time.min, the_time.sec)
	end
end
