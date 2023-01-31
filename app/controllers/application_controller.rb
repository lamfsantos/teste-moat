class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	add_flash_types :success,:warning,:danger

	include SessionsHelper

	private
		def require_logged_in_user
			unless user_signed_in?
				flash[:danger] = 'Restricted area. Please log in.'
				redirect_to root_path
			end
		end
end
