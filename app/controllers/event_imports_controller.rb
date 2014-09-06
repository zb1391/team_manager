class EventImportsController < ApplicationController
  def new
    @event_import = EventImport.new
  end

  def create
    unless params[:event_import].nil?
      @event_import = EventImport.new(params[:event_import])
      if @event_import.save
        redirect_to events_path, notice: "Imported Events Successfully."
      else
        render :new
      end
    else
      redirect_to new_event_import_path, notice: "Please provide a file"
    end
  end
end