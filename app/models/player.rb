class Player < ActiveRecord::Base
	belongs_to :team

	validates :first_name, :last_name, :phone, :email, presence: true
	validates :phone, length: {is: 10}
end
