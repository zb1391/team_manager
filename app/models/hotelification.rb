class Hotelification < ActiveRecord::Base
	belongs_to :event
	belongs_to :hotel
end
