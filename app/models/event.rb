class Event < ActiveRecord::Base
	has_many :hotelifications
	has_many :hotels, :through => :hotelifications
	accepts_nested_attributes_for :hotelifications
	belongs_to :team
	belongs_to :eventtype
	belongs_to :location
	validates  :the_date, :the_time, presence: true
	validate   :tournament_has_end_date

	def self.import(file)
	  CSV.foreach(file.path, headers: true) do |row|
	    cur_row = row.to_hash
	    db = Hash.new
	    db["the_date"] = Date.parse(cur_row["the_date"])
	    #Parse date - leave this in case format is dd/mm/yy
	    #date = cur_row["the_date"].split("/")
	    #db["the_date"] = Date.new(date[2].to_i, date[0].to_i)
	    
	    #Convert the time to proper value
	    time = cur_row["the_time"].split(":")
	    hour = 0
	    if time[2][-2 .. -1] == "PM"
	    	hour = time[0].to_i % 12 + 12
	    else
	    	hour = time[0].to_i
	    end
	    db["the_time"] = Time.utc(2000,"jan",1,hour,time[1].to_i,0)

	    #Get the eventtype_id from the string provided in the file
	    type = Eventtype.find_by name: cur_row["eventtype"]
	    db["eventtype_id"] = type[:id]

	    #Get the location from the string name provided in file
	    location = Location.find_by name: cur_row["location"]
	    db["location_id"] = location[:id]

	    #Get the court number
	    db["court"] = cur_row["court"]

	    #Get a description
	    db["description"] = cur_row["description"]

	    #Get the team by the string provided
	    team = Team.find_by name: cur_row["team"]
	    puts "looking for #{cur_row["team"]}"
	    puts "got #{team}"
	    db["team_id"] = team.id

	    puts db

	    Event.create! db

	  end
	end

	def tournament_has_end_date
		if eventtype.name == "tournament" && end_date.nil?
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
		end_date.strftime("%b-%d-%y")
	end
	def formatted_date
		the_date.strftime("%b-%d-%y")
	end
	def formatted_eventtype
		eventtype.name.split.map(&:capitalize).join(' ')
	end

end
