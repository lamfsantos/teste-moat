class UsersController < ApplicationController
	def new
		@user = User.new

		roles_controller = RolesController.new
		@roles = roles_controller.get_all
	end

	def create
		
	end
end
