class Tournament < ActiveRecord::Base
	has_many :organizations, :dependent => :destroy
	validates :name, :the_date, :price, presence: true


	def tournament_teams
		Club.search(:organization_tournament_id_eq => id).result.order(:gender,:grade).to_a
	end
end
