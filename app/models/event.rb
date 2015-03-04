class Event < ActiveRecord::Base
	scope :between, lambda {|the_start_time, the_end_time|
		{:conditions => ["? < the_date  AND the_date < ?", Date.parse(the_start_time.to_s), Date.parse(the_end_time.to_s)]}
	}
	has_many :hotelifications
	has_many :hotels, :through => :hotelifications
	accepts_nested_attributes_for :hotelifications, reject_if: :all_blank
	belongs_to :team
	belongs_to :eventtype
	belongs_to :location
	validates  :the_date, presence: true
	validates   :the_time, presence: true,
		unless: Proc.new {|a| a.eventtype_name == "tournament"}
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
		time = the_time || Time.new()
		DateTime.new(the_date.year, the_date.month, the_date.day, time.hour, time.min, time.sec)
	end

	def start_datetime
		start_time()
	end
	def end_datetime
		time = the_time || Time.new()
		endtime = end_time || time+1.hour
		unless end_date.blank?
			return DateTime.new(end_date.year, end_date.month, end_date.day, endtime.hour, endtime.min, endtime.sec)
		else
			return DateTime.new(the_date.year, the_date.month, the_date.day, endtime.hour, endtime.min, endtime.sec)
		end
	end

	def calendar_title
		"#{eventtype.formatted_name} - #{team.name}"
	end

	def as_json(options = {})
		{
			id: self.id,
			title: calendar_title,
			description: self.description,
			location: self.location_name,
			directions: self.location.try(:directions),
			eventtype: self.eventtype.formatted_name,
			team_name: self.team_name,
			start: start_datetime,
			enddate: end_datetime,
			allDay: eventtype_name=="tournament",
			recurring: false,
			url: Rails.application.routes.url_helpers.event_path(id) 
		}
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


	def when
		if eventtype_name == "tournament"
			if the_date == end_date
				the_date.strftime('%B %d (All Day)')
			else
				"#{the_date.strftime('%B %d')} - #{end_date.strftime('%B %d')}"
			end
		else
			start_datetime.strftime('%B %d, %I:%M %P')
		end
	end

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
