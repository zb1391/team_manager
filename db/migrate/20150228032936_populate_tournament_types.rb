class PopulateTournamentTypes < ActiveRecord::Migration
  def up
  	TournamentType.create(name: 'Invitational')
  	TournamentType.create(name: 'One Day Shootout')
  	TournamentType.create(name: 'Other')
  end

  def down
  	TournamentType.destroy_all
  end
end
