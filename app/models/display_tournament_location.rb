class DisplayTournamentLocation < ActiveRecord::Base
	belongs_to :display_tournament
	belongs_to :location
end