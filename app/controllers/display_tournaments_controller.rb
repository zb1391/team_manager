class DisplayTournamentsController < ApplicationController
  before_filter :authenticate
  # GET /tournaments
  # GET /tournaments.json
  def index
    @tournament_types = TournamentType.except_other
    @display_tournaments = DisplayTournament.all.order(active: :desc)
    # @tournaments = Tournament.order("the_date DESC").page(params[:page]).per(7)
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
  def show
    @invitationals = TournamentType.find_by_name('Invitational').tournaments.active_tournaments    
    @display_tournament = DisplayTournament.find(params[:id])
  end

  # GET /tournaments/new
  def new        
    @invitationals = TournamentType.find_by_name('Invitational').tournaments.active_tournaments
    @display_tournament = DisplayTournament.new(genders: 'Both', min_grade: 3, max_grade: 12)
    if display_tournament_params[:tournament_type_id]
      tournament_type = TournamentType.find(display_tournament_params[:tournament_type_id])
    else
      tournament_type = TournamentType.find_by_name("Invitational")
    end
    @display_tournament.tournament_type_id = tournament_type.id
    @display_tournament.display_tournament_locations.build
  end

  # GET /tournaments/1/edit
  def edit
    @display_tournament = DisplayTournament.find(params[:id])
    @display_tournament.display_tournament_locations.build if @display_tournament.display_tournament_locations.empty?
    @invitationals = TournamentType.find_by_name('Invitational').tournaments.active_tournaments
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    @display_tournament = DisplayTournament.new(display_tournament_params)
    respond_to do |format|
      if @display_tournament.save
        format.html { redirect_to @display_tournament, notice: 'Display Tournament was successfully created.' }
      else
        @invitationals = TournamentType.find_by_name('Invitational').tournaments.active_tournaments
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
        @invitationals = TournamentType.find_by_name('Invitational').tournaments.active_tournaments
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
        :price, :genders, :min_grade, :tournament_type_id,
        :max_grade, :active, :guaranteed_games,
        display_tournament_locations_attributes: [:_destroy,:id, :location_id])
    end
end
