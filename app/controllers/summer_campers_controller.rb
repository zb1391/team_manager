class SummerCampersController < ApplicationController
  before_action :set_summer_camper, only: [:show, :edit, :update, :destroy]

  # GET /summer_campers
  # GET /summer_campers.json
  def index
    @summer_campers = SummerCamper.all
    @summer_camps = SummerCamp.all.order(start_date: :desc)
  end

  # GET /summer_campers/1
  # GET /summer_campers/1.json
  def show
  end

  # GET /summer_campers/new
  def new
    @summer_camper = SummerCamper.new
  end

  # GET /summer_campers/1/edit
  def edit
  end

  # POST /summer_campers
  # POST /summer_campers.json
  def create
    @summer_camper = SummerCamper.new(summer_camper_params)

    respond_to do |format|
      if @summer_camper.save
        EventMailer.new_camper(@summer_camper).deliver
        format.html { redirect_to @summer_camper, notice: 'Summer camper was successfully created.' }
        format.json { render action: 'show', status: :created, location: @summer_camper }
      else
        format.html { render action: 'new' }
        format.json { render json: @summer_camper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /summer_campers/1
  # PATCH/PUT /summer_campers/1.json
  def update
    respond_to do |format|
      if @summer_camper.update(summer_camper_params)
        format.html { redirect_to @summer_camper, notice: 'Summer camper was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @summer_camper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /summer_campers/1
  # DELETE /summer_campers/1.json
  def destroy
    @summer_camper.destroy
    respond_to do |format|
      format.html { redirect_to summer_campers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_summer_camper
      @summer_camper = SummerCamper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def summer_camper_params
      params.require(:summer_camper).permit(:summer_camp_id,:first_name, :last_name, 
        :address, :city, :state, :zip, 
        :gender, :grade, :email, 
        :home_phone, :cell_phone, :waiver_name, :waiver_date,
        :amount_owe, :amount_paid,
        {:summer_camp_ids => []},
        campifications_attributes: [:id,:summer_camp_id, :summer_camper_id])
    end
end
