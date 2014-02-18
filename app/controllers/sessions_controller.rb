class SessionsController < ApplicationController
  def new
  	@my_status="sign in"
  end

  def create
  	user = Coach.authenticate(params[:session][:email], params[:session][:password])

  	if user.nil?
  		@my_status = "ERROR invalid login credentials"
  		render 'new'
  	else
  		sign_in user
  		redirect_to coaches_path
  	end

  end

  def destroy
  	sign_out
  	redirect_to coaches_path
  end
end
