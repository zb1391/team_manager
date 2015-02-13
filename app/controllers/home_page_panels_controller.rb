class HomePagePanelsController < ApplicationController
  before_filter :get_link_paths, only: [:new, :create, :edit, :update]

  def index
    @home_page_panels = HomePagePanel.all.order("is_active DESC",:priority_order)
    @active_panels = HomePagePanel.active_panels
  end
  
  def new
  	@home_page_panel = HomePagePanel.new()
  end

  def create
  	@home_page_panel = HomePagePanel.new(home_page_panel_params)
  	if @home_page_panel.save
  		redirect_to @home_page_panel, notice: 'Panel was successfully created.'
  	else
  		render action: 'new'
  	end
  end

  def show
    @home_page_panel = HomePagePanel.find(params[:id])
  end

  def edit
    @home_page_panel = HomePagePanel.find(params[:id])
  end

  def update
    @home_page_panel = HomePagePanel.find(params[:id])
    if @home_page_panel.update(home_page_panel_params)
      redirect_to @home_page_panel, notice: 'Panel was updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    if HomePagePanel.count > 3
      @home_page_panel = HomePagePanel.find(params[:id])
      if @home_page_panel.is_active
        flash[:error] = "Cannot destroy an active panel"
      else
        @home_page_panel.destroy
      end
    else
      flash[:error] = "There must always be at least 3 panels"
    end
    redirect_to home_page_panels_path

  end

  def panel_order
    panels = params[:panel].reject!{|key, value| value[:priority_order].blank?}
    puts panels
    unless panels.nil?
      numbers = panels.collect{|key, value| value[:priority_order]}.uniq

    else
      numbers = []
      panels = {}
    end
    puts 'numbers'
    if numbers.count == 3 && panels.coudasdadadant == 3
      begin
        HomePagePanel.transaction do
          HomePagePanel.clear_order!
          panels.each do |key, value|
            panel = HomePagePanel.find(key)
            binding.pry
            panel.update_attributes!(priority_order: value[:priority_order])
          end
        end
      rescue
        flash[:error] = "Transaction Failed. Make sure only numbers 1-3"
      end
    else
      flash[:error] = "Error You must provide 3 panels with unique numbers"
    end
    redirect_to home_page_panels_path
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def home_page_panel_params
  	params.require(:home_page_panel).permit(:title, :html, :additional_link,:additional_link_text,
      :is_active, :priority_order)
  end

  def get_link_paths
    gon.links = []
    HomePageFile.all.each{|file| gon.links << { label: file.name,  value: file.the_file.url } }
    gon.links << {label: "Gym Ratz About Page", value: page_gym_ratz_about_path}
    gon.links << {label: "Clinics Page", value: page_clinics_path}
    gon.links << {label: "Camps Page", value: page_camps_path}
    gon.links << {label: "Leagues and Tournaments Page", value: page_leagues_path}
  end
end