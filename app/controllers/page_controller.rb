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
    @instagram = Instagram.user_liked_media
  end

  def photo_gallery
    @instagram = Instagram.user_liked_media
    if !params[:img_id].blank?
      @pic = @instagram[params[:img_id].to_i]
    else
      @pic = @instagram[0]
    end
    @comments = [];
    comment=""
    if @pic.caption
      comment = @pic.caption
    else
      comment = ""
    end
    @comments << {:name => @pic.user.name, :comment => comment} 
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
    @tournaments = Event.search(:eventtype_name_cont => "tournament",:the_date_gteq => Date.today).result.order(:the_date,:location_id,:team_id).to_a
  end
end
