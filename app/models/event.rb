class Event < ActiveRecord::Base
	belongs_to :team
	has_one :eventtype
end
