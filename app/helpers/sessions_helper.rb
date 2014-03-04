module SessionsHelper
	def sign_in(user)
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		current_user = user
		puts "#{current_user} has signed in"
	end

	def current_user=(user)
		@current_user= user
	end

	def current_user
		@current_user ||= user_from_remember_token
	end

	def sign_out
		cookies.delete(:remember_token)
		current_user=nil
	end

	def signed_in?
		!current_user.nil?
	end

	def proper_coach?(coach)
		signed_in? && current_user.id == coach.id
	end
	
	def is_admin?
		signed_in? && current_user.admin?
	end

	def current_coach?(user)
		user== current_user
	end
	def deny_access
		redirect_to new_session_path, :notice => "You do not have access to this page"
	end

	def authenticate
      deny_access unless is_admin?
    end

    def correct_user
      @coach = Coach.find(params[:id])
      redirect_to(new_session_path) unless (current_coach?(@coach) || is_admin?)
    end
	
	private
		def user_from_remember_token
			Coach.authenticate_with_salt(*remember_token)
		end

		def remember_token
			cookies.signed[:remember_token] || [nil,nil]
		end
end
