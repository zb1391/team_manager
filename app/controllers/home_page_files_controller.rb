class HomePageFilesController < ApplicationController
  before_action :set_home_page_file, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, :only => [:new, :destroy,:edit, :update]
  # GET /home_page_files
  # GET /home_page_files.json
  def index
    @home_page_files = HomePageFile.all
  end

  # GET /home_page_files/1
  # GET /home_page_files/1.json
  def show
  end

  # GET /home_page_files/new
  def new
    @home_page_file = HomePageFile.new
  end

  # GET /home_page_files/1/edit
  def edit
  end

  # POST /home_page_files
  # POST /home_page_files.json
  def create
    @home_page_file = HomePageFile.new(home_page_file_params)

    respond_to do |format|
      if @home_page_file.save
        format.html { redirect_to @home_page_file, notice: 'Home page file was successfully created.' }
        format.json { render action: 'show', status: :created, location: @home_page_file }
      else
        format.html { render action: 'new' }
        format.json { render json: @home_page_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /home_page_files/1
  # PATCH/PUT /home_page_files/1.json
  def update
    respond_to do |format|
      if @home_page_file.update(home_page_file_params)
        format.html { redirect_to @home_page_file, notice: 'Home page file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @home_page_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /home_page_files/1
  # DELETE /home_page_files/1.json
  def destroy
    @home_page_file.destroy
    respond_to do |format|
      format.html { redirect_to home_page_files_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home_page_file
      @home_page_file = HomePageFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_page_file_params
      params.require(:home_page_file).permit(:name, :the_file)
    end
end
