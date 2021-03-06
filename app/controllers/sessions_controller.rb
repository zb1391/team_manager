class SessionsController < ApplicationController
  def new
  	@my_status="Sign in"
  end

  def create
  	user = Coach.authenticate(params[:session][:email], params[:session][:password])

  	if user.nil?
  		@my_status = "ERROR: invalid email/password"
  		render 'new'
  	else
  		sign_in user
  		redirect_to root_path
  	end

  end

  def destroy
  	sign_out
  	redirect_to root_path
  end
end
