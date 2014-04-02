class Campification < ActiveRecord::Base
	belongs_to :summer_camper
	belongs_to :summer_camp
end
