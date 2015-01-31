class TryoutsController < ApplicationController
  def new
  	@tryout = Tryout.new
    @teams = Team.all
  end

  def create
  	@tryout = Tryout.new(tryout_params)
  	if @tryout.save
  		redirect_to @tryout, notice: 'Tryout was successfully created.'
  	else
  		render action: 'new'
  	end
  end

  def index
    @tryouts = Tryout.order('id DESC')
  end
  def show
    @tryout = Tryout.find(params[:id])
  end

  def edit
    @tryout = Tryout.find(params[:id])
  end

  def update
    @tryout = Tryout.find(params[:id])
    if @tryout.update(tryout_params)
      redirect_to @tryout, notice: 'Tryout was updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    @tryout = Tryout.find(params[:id])
    @tryout.destroy
    redirect_to root_path
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def tryout_params
  	params.require(:tryout).permit(:season, tryout_dates_attributes: 
  																	[:_destroy, :id, :date, tryout_times_attributes: 
  																		[:_destroy, :id, :time, team_tryout_times_attributes:
  																			[:_destroy, :id, :team_id]]])
  end
end