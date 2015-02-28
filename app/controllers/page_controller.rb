class PageController < ApplicationController
  before_filter :authenticate, only: [:admin_search]
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
  def home
    @active_panels = HomePagePanel.active_panels
    @images = ['dts1_bw_qt.png', 'gym_ratz_bw_qt.png', 'court_bw_qt.png']
  end

  def clinics
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
    binding.pry
    @tryout = Tryout.last
  end

  def photo_gallery
    @instagram = Instagram.user_liked_media({:count => 18})
    
    if !params[:img_id].blank?
      @picid = params[:img_id]
      @pic = @instagram[params[:img_id].to_i]
    else
      @picid = 0
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

    @prev = @picid.to_i;
    @prev = @prev -1
    @next = @picid.to_i; 
    @next = @next + 1
    if @picid.to_i == 0
      @prev = @instagram.size-1;
    end
    if @picid.to_i == @instagram.size-1
      @next = 0;
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
