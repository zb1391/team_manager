class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, :only => [:index, :destroy, :edit, :update]
  before_filter :get_grades

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.all.order(:tournament_id)
    @tournaments = Tournament.all.order(the_date: :desc)
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new(manual_fee_entry: false)
    @organization.clubs.build
    @tournaments = Tournament.active_tournaments
    if !params[:id].blank?
      @tournament = Tournament.find(params[:id])
      @organization.tournament_id = params[:id]
    elsif !params[:tournament].nil?
        if !params[:tournament][:id].blank?
          @t = Tournament.find(params[:tournament][:id])
          @organization.tournament_id = @t.id
        end
    end

    #summer_camper_registration_path(:param1 => @summer_camper.id)
  end

  # GET /organizations/1/edit
  def edit
    @tournaments = Tournament.active_tournaments
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)
    if organization_params[:manual_fee_entry] == "0" || organization_params[:manual_fee_entry].nil?
      @organization.amount_owe = @organization.tournament.price*@organization.clubs.size
    end
    respond_to do |format|
      if @organization.save
        EventMailer.tournament_registration(@organization).deliver
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render action: 'show', status: :created, location: @organization }
      else
        @tournaments = Tournament.active_tournaments
        @organization.clubs.build if @organization.clubs.empty?
        format.html { render action: 'new' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        if organization_params[:manual_fee_entry] == "0"
          @organization.update_attribute(:amount_owe, @organization.tournament.price*@organization.clubs.size)
        end
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        @tournaments = Tournament.active_tournaments
        @organization.clubs.build if @organization.clubs.empty?
        format.html { render action: 'edit' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end

  private

    def get_grades
      @grades = [['3rd Grade','3rd'], ['4th Grade','4th'], ['5th Grade','5th'],
                 ['6th Grade','6th'], ['7th Grade','7th'], ['8th Grade','8th'],
                 ['9th Grade','9th'], ['10th Grade','10th'],['11th Grade','11th'],
                 ['12th Grade','12th']]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :contact_name, :email, :phone, :tournament_id, :manual_fee_entry,
      :amount_owe, :amount_paid, :paid_at,
      clubs_attributes: [:coach, :id, :_destroy, :gender, :grade, :email, :cell,:use_organization_info])
    end
end
