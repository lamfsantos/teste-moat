class UsersController < ApplicationController
	
	def new
		@user = User.new

		@roles = get_roles
	end

	def create
		#user_params['role'] = set_role_on_new_user(user_params, get_roles)

		@user = User.new(user_params)
		@roles = get_roles
		
		if @user.save
			flash[:success] = 'User registered.'
			redirect_to root_url()
		else
			render 'new'
		end
	end

	def get_roles
		roles_controller = RolesController.new
		roles_controller.get_all
	end

	def edit
		@roles = get_roles
	end

	def update
		if current_user.update(user_params)
			flash[:success] = 'Updated'
			redirect_to artists_path(current_user)
		else
			render 'edit'
		end
	end

	private
		def user_params
			params.require(:user).permit(:full_name, :username, :password, :password_confirmation, :role)
		end

	private
		def set_role_on_new_user(user_params, roles)
			role = nil
			roles = Role.all.order('id ASC').to_a.map {|u| u } 

			i = 0
			loop { 
				if roles[i]['id'].to_s  == user_params['role']
					role = roles[i]
				end

				if i == roles.size - 1
					break
				end

				i+=1
			}

			role
		end
end
