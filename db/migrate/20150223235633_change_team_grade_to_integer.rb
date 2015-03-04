class ChangeTeamGradeToInteger < ActiveRecord::Migration
  def up
  	teams = Team.all.collect{|team| {id: team.id, grade: team.grade}}
  	remove_column :teams, :grade
  	add_column :teams, :grade, :integer

  	teams.each do |t|
  		team = Team.find(t[:id])
  		new_grade_value = t[:grade].gsub(/st|nd|rd|th/,"").to_i
  		team.update_attributes(grade: new_grade_value)
  	end
  end

  def down
  	teams = Team.all.collect{|team| {id: team.id, grade: team.grade}}
  	remove_column :teams, :grade
  	add_column :teams, :grade, :string
  	teams.each do |t|
  		team = Team.find(t[:id])
  		new_grade_value = t[:grade].ordinalize
  		team.update_attributes(grade: new_grade_value)
  	end
  end

end
