class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, :only => [:new, :destroy,:edit, :update]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all.order(:gender, :grade, :team_type)
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
    @not_me = Coach.search(:email_not_eq =>"zmb1391@gmail.com").result.to_a
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
    @not_me = Coach.search(:email_not_eq =>"zmb1391@gmail.com").result.to_a
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
        format.html { render action: 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
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
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:team_name, :encrpyted_password, :password, :password_confirmation, 
        :coach_id, :gender, :grade, :team_type)
    end
end
