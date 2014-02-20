class Event < ActiveRecord::Base
	belongs_to :team
	belongs_to :eventtype
	belongs_to :hotel
	belongs_to :location
	validates  :the_date, :the_time, presence: true
	def start_time
		DateTime.new(the_date.year, the_date.month, the_date.day, the_time.hour, the_time.min, the_time.sec)
	end
	def has_hotel?
		!hotel.nil?
	end

	def self.begin_time
		Time.utc(2000,"jan",1,8,0,0)
	end

	def self.stopping_time
		Time.utc(2000,"jan",1,22,0,0)
	end
	#starting day
	def self.start_of_week
		Date.today.beginning_of_week(start_day= :sunday).strftime('%b-%d-%y')
	end

	#endingru day
	def self.end_of_week
		Date.today.end_of_week(start_day= :sunday).strftime('%b-%d-%y')
	end

	#def all 
	#find all events on a given date
	def self.todays_events(cur_date)
	    Event.where("the_date = ?", cur_date).order(:the_time)
	end

	def self.current_events(cur_date, cur_time)
		Event.where("the_date =? AND the_time >= ? AND the_time < ?", cur_date, cur_time, (cur_time+1.hour) ).order(:the_time)
	end
	def formatted_date
		the_date.strftime("%b-%d-%y")
	end
	def formatted_eventtype
		eventtype.name.split.map(&:capitalize).join(' ')
	end
end
