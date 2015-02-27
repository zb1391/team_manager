class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, :only => [:index,:new, :destroy,:edit, :update]
  before_filter :prepare_for_mobile, :only => [:index]

  # GET /events
  # GET /events.json
  def index
    respond_to do |format|
      format.html
      format.mobile
      format.json {render :json => @events}
    end
  end

  def tournaments
    get_tournaments
    respond_to do |format|
      format.json {render :json => @tournaments}
    end
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
    @team_id = params[:team_id]
    2.times {@event.hotelifications.build}
  end

  # GET /events/1/edit
  def edit
    2.times {@event.hotelifications.build} unless @event.hotels.any?
  end

  def email
    event = Event.find(params[:event_id])
    EventMailer.remind_team_event(event.team, event).deliver
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
        @event.hotelifications.build unless @event.hotels.any?
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    oldevent = @event.clone
    respond_to do |format|
      if @event.update(event_params)
        EventMailer.changed_team_event(@event.team,@event,oldevent).deliver
        format.html { redirect_to events_path, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        @event.hotelifications.build unless @event.hotels.any?
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

  def reschedule
    @event = Event.find(params[:id] || params[:event_id])
    attrs = @event.attributes.except('id','created_at','updated_at')
    @the_date = attrs.delete('the_date')+1.week
    @end_date = attrs.delete('end_date') unless attrs['end_date'].nil?
    attrs['the_date'] = @the_date
    attrs['end_date'] = @end_date || nil
    event = Event.create(attrs)
    EventMailer.new_team_event(event.team,event).deliver
    redirect_to events_path, notice: "#{event.calendar_title} Rescheduled for #{event.the_date.strftime('%b %d')}"
  end
  private

    def prepare_for_mobile
      if mobile_device?
        request.format = :mobile unless request.format == :json # ajax needs to be json
        get_tournaments unless request.format == :json
        @events = Event.search(the_date_gteq: Date.today())
                      .result
                      .order(:the_date, :the_time)
                      .page(params[:page])
                      .per(5)
      else
        @events = Event.all
        @events = Event.between(params['start'], params['end']) if (params['start'] && params['end'])
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def get_tournaments
      tournament_type = Eventtype.find_by_name('tournament').id

      @tournaments = Event.search(eventtype_id_eq: tournament_type, the_date_gteq: Date.today())
                          .result
                          .order(:the_date, :the_time)
                          .page(params[:page])
                          .per(5)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:the_date, 
        :the_time, :location_id, :eventtype_id,
        :end_time,:team_id, :court, 
        :end_date, :description,
         hotelifications_attributes: [:id, :hotel_id, :event_id])
    end
end
