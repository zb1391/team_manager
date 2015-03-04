class CoachesController < ApplicationController
  before_action :set_coach, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, :only => [:show, :new, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  # GET /coaches
  # GET /coaches.json
  def index
    @coaches = Coach.all.order(:last_name)
    not_me = Coach.search(:email_not_eq =>"zmb1391@gmail.com").result.order(:last_name)
    @admins = not_me.select{|coach| coach.admin == true}
    @coaches = not_me.select{|coach| coach.admin == false}
  end

  # GET /coaches/1
  # GET /coaches/1.json
  def show
  end

  # GET /coaches/new
  def new
    @coach = Coach.new
  end

  # GET /coaches/1/edit
  def edit
  end

  # POST /coaches
  # POST /coaches.json
  def create
    @coach = Coach.new(coach_params)

    respond_to do |format|
      if @coach.save
        format.html { redirect_to coaches_path, notice: 'Coach was successfully created.' }
        format.json { render action: 'show', status: :created, location: @coach }
      else
        format.html { render action: 'new' }
        format.json { render json: @coach.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coaches/1
  # PATCH/PUT /coaches/1.json
  def update
    binding.pry
    respond_to do |format|
      if @coach.update(coach_params)
        format.html { redirect_to coaches_path, notice: 'Coach was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coach.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coaches/1
  # DELETE /coaches/1.json
  def destroy
    @coach.destroy
    if @coach.check_for_teams
      respond_to do |format|
        format.html { redirect_to coaches_url }
        format.json { head :no_content }
      end
    else
      redirect_to @coach, :notice => "Coach is still managing teams."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coach
      @coach = Coach.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coach_params
      params.require(:coach).permit(:first_name, :last_name, :phone, :email, 
        :password, :password_confirmation, :needs_encryption)
    end

end
