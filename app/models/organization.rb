class Organization < ActiveRecord::Base
	has_many :clubs, :dependent => :destroy
	accepts_nested_attributes_for :clubs, :reject_if => lambda { |a| a[:coach].blank? }, allow_destroy: true
end
