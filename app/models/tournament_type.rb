class TournamentType < ActiveRecord::Base
	has_many :tournaments
	has_many :display_tournaments
	scope :except_other, -> {where('name <> ?', "Other")}
end