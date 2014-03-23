class Organization < ActiveRecord::Base
	belongs_to :tournament
	has_many :clubs, :dependent => :destroy
	accepts_nested_attributes_for :clubs, :reject_if => lambda { |a| a[:coach].blank? }, allow_destroy: true
	validates :phone, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	validates :name, :contact_name, :email, :phone, presence: true
	validate :atleast_one_club

	def atleast_one_club
		if clubs.empty?
			errors.add(:clubs, "You Must Register at least One Team --- Please click the Add Team button below")
		end
	end
end
