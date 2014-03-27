class Tournament < ActiveRecord::Base
	has_many :organizations, :dependent => :destroy
	validates :name, :the_date, :price, presence: true


	def tournament_teams
		Club.search(:organization_tournament_id_eq => id).result.order(:gender,:grade).to_a
	end

	def formatted_date
		the_date.strftime("%b-%d-%y")
	end
end
