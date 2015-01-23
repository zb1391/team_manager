class DisplayTournamentsController < ApplicationController
  before_filter :authenticate
  # GET /tournaments
  # GET /tournaments.json
  def index
    # @tournaments = Tournament.order("the_date DESC").page(params[:page]).per(7)
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
  def show
    @invitationals = Tournament.find_active_invitationals
    
    @display_tournament = DisplayTournament.find(params[:id])
  end

  # GET /tournaments/new
  def new
    @invitationals = Tournament.find_active_invitationals
    @display_tournament = DisplayTournament.new
    @display_tournament.display_tournament_locations.build
  end

  # GET /tournaments/1/edit
  def edit
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    @display_tournament = DisplayTournament.new(display_tournament_params)
    respond_to do |format|
      if @display_tournament.save
        format.html { redirect_to @display_tournament, notice: 'Display Tournament was successfully created.' }
      else
        @invitationals = Tournament.find_active_invitationals
        @display_tournament.display_tournament_locations.build if @display_tournament.display_tournament_locations.empty?
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /tournaments/1
  # PATCH/PUT /tournaments/1.json
  def update
    @display_tournament = DisplayTournament.find(params[:id])
    respond_to do |format|
      if @display_tournament.update(display_tournament_params)
        format.html { redirect_to @display_tournament, notice: 'Tournament was successfully updated.' }
        format.json { head :no_content }
      else
        @display_tournament.display_tournament_locations.build if @display_tournament.display_tournament_locations.empty?
        format.html { render action: 'edit' }
        format.json { render json: @display_tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    @display_tournament.destroy
    respond_to do |format|
      format.html { redirect_to tournaments_url }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def display_tournament_params
      params.require(:display_tournament).permit(:season, 
        :price, :genders, :min_grade, 
        :max_grade, :active, :guaranteed_games,
        display_tournament_locations_attributes: [:_destroy,:id, :location_id])
    end
end
