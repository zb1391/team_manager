class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper :all
  protect_from_forgery with: :exception
  include SessionsHelper
  include EventsHelper
  before_filter :set_admin_routes
    
  def set_admin_routes
    gon.admin_routes = admin_routes
  end
  def mobile_device?
  	request.user_agent =~ /Mobile|webOS/
  end
  helper_method :mobile_device?

  private 
  def admin_index_pages
    [
      {label: "Attachments", value: home_page_files_path},
      {label: "Coupons", value: coupons_path},
      {label: "Display Tournaments", value: display_tournaments_path},
      {label: "Events", value: events_path},
      {label: "Home Page Files", value: home_page_files_path},
      {label: "Home Page Panels", value: home_page_panels_path},
      {label: "Hotels", value: hotels_path},
      {label: "Locations", value: locations_path},
      {label: "Organizations",value:  organizations_path},
      {label: "Players", value: players_path},
      {label: "Summer Camps", value: summer_camps_path},
      {label: "Registered Tournament Teams",value:  organizations_path},
      {label: "Summer Campers", value: summer_campers_path},
      {label: "Teams", value: teams_path},
      {label: "Tournaments", value: tournaments_path},
      {label: "Tryouts", value: tryouts_path},
      {label: "Sign Out", value: session_path(:id)},
      {label: "Schedule", value: events_path}
    ]
  end

  def admin_routes
    routes = admin_index_pages
    Team.all.each do |team|
      routes << {label: team.name, value: team_path(team)}
    end
    return routes
  end
  
end
