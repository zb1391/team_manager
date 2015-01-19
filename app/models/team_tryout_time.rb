class TeamTryoutTime < ActiveRecord::Base
	belongs_to :team
	belongs_to :tryout_time
end