class PageController < ApplicationController
  def home
  end

  def weekly_calendar
  	@q = Event.search(params[:q])
  	@teams = @q.result(distinct: true)
  end
end
