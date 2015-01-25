class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper :all
  protect_from_forgery with: :exception
  include SessionsHelper
  include EventsHelper

  def mobile_device?
  	request.user_agent =~ /Mobile|webOS/
  end
  helper_method :mobile_device?
end
