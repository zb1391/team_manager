class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :password, :update_password]
  before_filter :authenticate, :only => [:new, :destroy,:edit, :update, :index]
  before_filter :get_coaches
  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all.order(:gender, :grade, :team_type)
    @event = Event.new
    2.times {@event.hotelifications.build}
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    respond_to do |format|
      format.html
      format.xls 
    end
  end

  # GET /teams/new
  def new
    @team = Team.new
    @team.build_home_page_file
  end

  # GET /teams/1/edit
  def edit
    gon.already_uploaded = @team.home_page_file.present?
    @not_me = Coach.search(:email_not_eq =>"zmb1391@gmail.com").result.to_a
    @team.build_home_page_file if @team.home_page_file.nil?

  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team }
      else
        @team.build_home_page_file if @team.home_page_file.nil?
        format.html { render action: 'new' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        @team.build_home_page_file if @team.home_page_file.nil?
        format.html { render action: 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def password
  end

  def update_password
    if @team.update(team_params)
      redirect_to @team, notice: 'Password was successfully updated.'
    else
      render action: 'password'
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.events.each do |e|
      e.destroy
    end
    @team.players.each do |p|
      p.destroy
    end
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id]||params[:team_id])
    end

    def get_coaches
      @not_me = Coach.search(:email_not_eq =>"zmb1391@gmail.com").result.to_a
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:team_name, :encrpyted_password, :password, :password_confirmation, 
        :coach_id, :gender, :grade, :team_type, :color, :should_validate_password,
        hotelifications_attributes: [:id, :hotel_id, :event_id],
        home_page_file_attributes: [:id, :name, :the_file])
    end
end
