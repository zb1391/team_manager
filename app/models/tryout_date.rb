class TryoutDate < ActiveRecord::Base
	belongs_to :tryout
	has_many :tryout_times, dependent: :destroy

	accepts_nested_attributes_for :tryout_times, allow_destroy: true

	validates :date, presence: {message: "You must enter a date"}
	validates_presence_of :tryout_times, message: "You must enter at least one time"
	def sorted_tryout_times
		tryout_times.order(:time)
	end

	def girls_tryout_times
		sorted_tryout_times.collect{|time| time.teams.where(gender: "Girls")}.flatten
	end

	def boys_tryout_times
		sorted_tryout_times.collect{|time| time.teams.where(gender: 'Boys')}.flatten
	end

	def has_girls_tryouts?
		girls_tryout_times.any?
	end

	def has_boys_tryouts?
		boys_tryout_times.any?
	end
end