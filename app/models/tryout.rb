class Tryout < ActiveRecord::Base
	has_many :tryout_dates, dependent: :destroy

	accepts_nested_attributes_for :tryout_dates

	validate :at_least_one_date

	def girls_teams
		teams_by_gender("Girls")
	end

	def boys_teams
		teams_by_gender("Boys")
	end

	def girls_tryout_dates
		tryout_dates.reject{|date| !date.has_girls_tryouts?}
	end

	def boys_tryout_dates
		tryout_dates.reject{|date| !date.has_boys_tryouts?}
	end

	private
	def teams_by_gender(gender)
  	tryout_dates.collect{|date| date.tryout_times
  																	.collect{|time| time.teams.where(gender: gender)}}
  																	.flatten
  end

	def at_least_one_date
		unless tryout_dates.any?
			errors.add(:tryout_dates, "you must choose at least one date")
		end
	end
end