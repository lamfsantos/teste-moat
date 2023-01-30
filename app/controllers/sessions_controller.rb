class SessionsController < ApplicationController
	def new
		
	end

	def create
		user = User.find_by(username: params[:session][:username].downcase)
	    if user && user.authenticate(params[:session][:password])
			sign_in(user)
			redirect_to albums_path(user)
	    else
			flash.now[:danger] = "Sorry, we couldn't find an account with this username. Please check you're using the right username and try again"
			render 'new'
		end
    end

    def destroy
	    sign_out
	    flash[:success] = 'Logout'
	    redirect_to login_path
	end
end
