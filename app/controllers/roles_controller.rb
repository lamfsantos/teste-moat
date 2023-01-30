class RolesController < ApplicationController
	def get_all
		Role.all
	end
end
