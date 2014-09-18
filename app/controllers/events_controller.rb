class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, :only => [:index,:new, :destroy,:edit, :update]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all.order('id DESC').page(params[:page]).per(10)
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  def import
    Event.import(params[:file])
    redirect_to teams_path, notice: "Events imported."
  end

  # GET /events/new
  def new
    @event = Event.new
    2.times {@event.hotelifications.build}
  end

  # GET /events/1/edit
  def edit
    2.times {@event.hotelifications.build}
  end

  def email
    event = Event.find(params[:event_id])
    event.team.players.each do |player|
      EventMailer.remind_team_event(event.team, event,player.email).deliver
      EventMailer.remind_team_event(event.team, event,player.parent_email).deliver
      # if !player.parent_email2.nil?
      #   EventMailer.remind_team_event(event.team, event,player.parent_email2).deliver
      # end
    end
    # EventMailer.remind_team_event(event.team, event).deliver
    redirect_to events_path, notice: 'Email was sent to all players!'
  end
  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    
    respond_to do |format|
      if @event.save
        EventMailer.new_team_event(@event.team,@event).deliver
        format.html { redirect_to teams_path, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    oldevent = @event
    respond_to do |format|
      if @event.update(event_params)
        EventMailer.changed_team_event(@event.team,@event,oldevent).deliver
        format.html { redirect_to events_path, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    EventMailer.destroyed_team_event(@event.team,@event).deliver
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:the_date, :the_time, :location_id, :eventtype_id, :end_time,:team_id, :court, 
        :end_date, :description, hotelifications_attributes: [:id, :hotel_id, :event_id])
    end
end
