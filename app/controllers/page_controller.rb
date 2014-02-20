class PageController < ApplicationController
  def home
  end

  def weekly_calendar
  	@teams = Team.find(:all)
  	@my_teams = Event.team_search(params[:which_teams])
  end
end
