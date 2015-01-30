class SummerCampsController < ApplicationController
  before_action :set_summer_camp, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate
  before_filter :get_summer_camp_price

  # GET /summer_camps
  # GET /summer_camps.json
  def index
    @summer_camps = SummerCamp.all
  end

  # GET /summer_camps/1
  # GET /summer_camps/1.json
  def show
  end

  # GET /summer_camps/new
  def new
    @summer_camp = SummerCamp.new(price: gon.summer_camp_price)
  end

  # GET /summer_camps/1/edit
  def edit
  end

  # POST /summer_camps
  # POST /summer_camps.json
  def create
    @summer_camp = SummerCamp.new(summer_camp_params)

    respond_to do |format|
      if @summer_camp.save
        format.html { redirect_to @summer_camp, notice: 'Summer camp was successfully created.' }
        format.json { render action: 'show', status: :created, location: @summer_camp }
      else
        format.html { render action: 'new' }
        format.json { render json: @summer_camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /summer_camps/1
  # PATCH/PUT /summer_camps/1.json
  def update
    respond_to do |format|
      if @summer_camp.update(summer_camp_params)
        format.html { redirect_to @summer_camp, notice: 'Summer camp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @summer_camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /summer_camps/1
  # DELETE /summer_camps/1.json
  def destroy
    @summer_camp.destroy
    respond_to do |format|
      format.html { redirect_to summer_camps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_summer_camp
      @summer_camp = SummerCamp.find(params[:id])
    end

    def get_summer_camp_price
      gon.summer_camp_price = SummerCamp.this_year_price
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def summer_camp_params
      params.require(:summer_camp).permit(:start_date, :end_date, 
        :end_registration_date,:price)
    end
end
