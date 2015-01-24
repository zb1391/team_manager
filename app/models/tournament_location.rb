class TournamentLocation < ActiveRecord::Base
	belongs_to :tournament
	belongs_to :location
end