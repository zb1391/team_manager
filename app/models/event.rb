class Event < ActiveRecord::Base
	has_many :hotelifications
	has_many :hotels, :through => :hotelifications
	accepts_nested_attributes_for :hotelifications, reject_if: :all_blank
	belongs_to :team
	belongs_to :eventtype
	belongs_to :location
	validates  :the_date, :the_time, presence: true
	validate   :tournament_has_end_date
	validates :team_name, :presence =>  { :message => " can't find team with that name" }
	validates :location_name, :presence => { :message => " can't find location with that name" }
	validates :eventtype_name, :presence => { :message => " can't find eventtype with that name" }
	#Getter/Setter for using user_name instead of user_id in form
	def team_name
		team.try(:name)
	end

	def team_name=(name)
		self.team = Team.where(:name => name)[0] if name.present?
	end

	def location_name
		location.try(:name)
	end

	def location_name=(name)
		self.location = Location.where(:name => name)[0] if name.present?
	end

	def eventtype_name
		eventtype.try(:name)
	end

	def eventtype_name=(name)
		self.eventtype = Eventtype.where(:name => name)[0] if name.present?
	end

	def tournament_has_end_date
		if eventtype_name == "tournament" && end_date.nil?
			errors.add(:end_date, "Tournament must have an end_date")
		end
	end
	def start_time
		DateTime.new(the_date.year, the_date.month, the_date.day, the_time.hour, the_time.min, the_time.sec)
	end

	#Times for Creating Weekly Calendar
	def self.begin_time
		#8 AM
		Time.utc(2000,"jan",1,8,0,0)
	end

	def self.stopping_time
		#10 PM
		Time.utc(2000,"jan",1,22,0,0)
	end


	#Days for Creating Weekly Calendar
	def self.start_of_week
		Date.today.beginning_of_week(start_day= :sunday).strftime('%b-%d-%y')
	end

	
	def self.end_of_week
		Date.today.end_of_week(start_day= :sunday).strftime('%b-%d-%y')
	end

	#Return all Events on A Particular Date on a Particular Time on A Particular Court
	def self.events_on_court_at_time(cur_date,cur_time,cur_court)
		Event.where("the_date =? AND the_time >= ? AND the_time < ? AND court = ?", cur_date, cur_time, 
			(cur_time+30.minutes), cur_court,).order(:the_time 	)
	end

	#Return a Single Event on A Particular Date on a Particular Time on A Particular Court
	def self.unique_event_on_court_at_time(cur_date,cur_time,cur_court)
		
		the_events = Event.where("the_date =? AND the_time >= ? AND the_time < ? AND court = ? AND eventtype_id = ?", cur_date, cur_time, 
			(cur_time+30.minutes), cur_court,1 ).order(:the_time)
		if the_events.nil?
			return nil 
		else
			return the_events[0]
		end
	end
	#Return a String of all TeamNames for an Event at a Particular Time On A Particular Court
	def self.teams_on_court_at_time(cur_date, cur_time, cur_court)
		the_event = events_on_court_at_time(cur_date,cur_time,cur_court)
		the_teams = ""
		the_event.each do |e|
			the_teams += "#{e.team.team_name}/"
		end
		return the_teams[0..-2]
	end


	##KEEP THIS
	def formatted_end_date
		end_date.strftime("%b %d-%y")
	end
	def formatted_date
		the_date.strftime("%b %d-%y")
	end
	def formatted_eventtype
		eventtype.name.split.map(&:capitalize).join(' ')
	end

end
