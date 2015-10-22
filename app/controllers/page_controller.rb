class PageController < ApplicationController
  before_filter :authenticate, only: [:admin_search, :admin_home]
  def admin_search
    if params[:redirect_path]
      if params[:redirect_path].include?('session')
        sign_out
        redirect_to root_path
      else
        redirect_to params[:redirect_path]
      end
    else
      redirect_to root_path
    end
  end
  
  def admin_home
  end

  def home
    @active_panels = HomePagePanel.active_panels
    @images = ['dts1_bw_qt.png', 'gym_ratz_bw_qt.png', 'court_bw_qt.png']
  end

  def clinics
    @active_p3 = SummerCamp.active_camps("P3")
  end

  def court_rentals
  end

  def parties
  end

  def leagues
    @tournament = Tournament.new
    one_day_shootout = TournamentType.find_by_name('One Day Shootout')
    invitational = TournamentType.find_by_name('Invitational')
    @one_day_shootout_display = one_day_shootout.display_tournaments.find_by_active(true)
    @invitational_display = invitational.display_tournaments.find_by_active(true)
    @one_day_shootouts = one_day_shootout.tournaments.active_tournaments
    @invitationals = invitational.tournaments.active_tournaments
  end

  def camps
    @coupons = Coupon.active_coupons
    @summer_camps = SummerCamp.summer_camps_this_year
    @tuition = @summer_camps.last.try(:price)
  end

  def gym_ratz_about
    @boys_teams = Team.boys.reject{|t| t.home_page_file.nil?}
    @girls_teams = Team.girls.reject{|t| t.home_page_file.nil?}
    @tryouts = Tryout.last
  end

  def photo_gallery
    @instagram = Instagram.user_liked_media({:count => 17, :max_like_id => params[:last]})
    respond_to do |format|
      format.html
      format.json { render json: @instagram }
    end
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

  def rosters
    @boys_teams = Team.boys.reject{|t| t.home_page_file.nil?}
    @girls_teams = Team.girls.reject{|t| t.home_page_file.nil?}
  end
end
