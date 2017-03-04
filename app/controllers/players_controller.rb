class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, :only => [:index, :show, :edit, :destroy]
  # GET /players
  # GET /players.json
  def index
    @players = Player.all.order(:last_name, :first_name, :team_id)
    respond_to do |format|
      format.html
      format.xls 
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)
    respond_to do |format|
      if @player.save
        format.html { redirect_to page_thank_you_path }
        format.json { render action: 'show', status: :created, location: @player }
      else
        format.html { render action: 'new' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        # TODO: email the player if there is a team associated
	# This email only goes out if the old_value is nil and new_value
	# is truthy
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    team = @player.team
    @player.destroy
    respond_to do |format|
      format.html { redirect_to team }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:first_name, 
        :last_name, 
        :phone, 
        :email, 
        :team_id, 
        :password,
        :parent_first_name, 
        :parent_last_name, 
        :parent_email, 
        :parent_email2,
        :parent_cell, 
        :emergency_phone, 
        :uniform_number,
        :home_town,
        :team_preference,
        :grade,
        :dob)
    end
end
