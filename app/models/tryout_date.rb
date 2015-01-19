class TryoutDate < ActiveRecord::Base
	belongs_to :tryout
	has_many :tryout_times

	accepts_nested_attributes_for :tryout_times

	def girls_tryout_times
		tryout_times.collect{|time| time.teams.where(gender: "Girls")}.flatten
	end

	def boys_tryout_times
		tryout_times.collect{|time| time.teams.where(gender: 'Boys')}.flatten
	end

	def has_girls_tryouts?
		girls_tryout_times.any?
	end

	def has_boys_tryouts?
		boys_tryout_times.any?
	end
end