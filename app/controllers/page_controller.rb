class PageController < ApplicationController
  def home
  end

  def clinics
  end

  def court_rentals
  end

  def parties
  end

  def leagues
    @tournament = Tournament.new
  end

  def camps
  end

  def gym_ratz_about
  end

  def contact
  end

  def thank_you
  end

  def page_unavailable
  end

  def summer_camper_registration
    @summer_camper = SummerCamper.find(params[:param1])
  end

  def tournament_manager
    @tournaments = Event.search(:eventtype_name_cont => "tournament").result.order(:the_date,:team_id).to_a
  end
end
