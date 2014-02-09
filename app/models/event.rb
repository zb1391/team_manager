class Event < ActiveRecord::Base
	belongs_to :team
	belongs_to :eventtype
end
