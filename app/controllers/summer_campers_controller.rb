class SummerCampersController < ApplicationController
  before_action :set_summer_camper, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, :only => [:index, :show, :edit, :destroy, :new]
   #      <%= link_to "Register Online",new_summer_camper_url,:class => "button-look-orange",
   #     :id => "no-hover-orange"
   #   %>
  
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
    @summer_camper = SummerCamper.new(waiver_date: Date.today, state: "NJ")
    @summer_camper.campifications.build
    @active_summer_camps = SummerCamp.active_summer_camps
  end

  # GET /summer_campers/1/edit
  def edit
    @active_summer_camps = SummerCamp.active_summer_camps
    @summer_camper.campifications.build if @summer_camper.campifications.empty?

  end

  # POST /summer_campers
  # POST /summer_campers.json
  def create
    @summer_camper = SummerCamper.new(summer_camper_params)
    @active_summer_camps = SummerCamp.active_summer_camps
    respond_to do |format|
      if @summer_camper.save
        EventMailer.new_camper(@summer_camper).deliver
        format.html { redirect_to page_summer_camper_registration_path(:param1 => @summer_camper.id)}
        format.json { render action: 'show', status: :created, location: @summer_camper }
      else
        @summer_camper.campifications.build if @summer_camper.campifications.empty?
        format.html { render action: 'new' }
        format.json { render json: @summer_camper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /summer_campers/1
  # PATCH/PUT /summer_campers/1.json
  def update
    @active_summer_camps = SummerCamp.active_summer_camps
    respond_to do |format|
      if @summer_camper.update(summer_camper_params)
      if summer_camper_params[:manual_fee_entry] == "0"
        total = 0
        @summer_camper.summer_camps.each do |summer_camp|
          total += summer_camp.price
        end
        @summer_camper.update_attribute(:amount_owe, total)
      end
        format.html { redirect_to @summer_camper, notice: 'Summer camper was successfully updated.' }
        format.json { head :no_content }
      else
        @summer_camper.campifications.build if @summer_camper.campifications.empty?
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
        :amount_owe, :amount_paid, :manual_fee_entry,
        campifications_attributes: [:id,:summer_camp_id, :summer_camper_id, :_destroy])
    end
end
