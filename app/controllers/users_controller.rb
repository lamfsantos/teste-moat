class UsersController < ApplicationController
	

	def new
		@user = User.new

		@roles = get_roles
	end

	def create
		@user = User.new(user_params)
		@roles = get_roles

		if @user.save
			flash[:success] = 'User registered.'
			redirect_to root_url
		else
			render 'new'
		end
	end

	def get_roles
		roles_controller = RolesController.new
		roles_controller.get_all
	end

	private
		def user_params
			params.require(:user).permit(:full_name, :username, :password, :password_confimration, :role)
		end
end
