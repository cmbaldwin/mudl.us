class ApplicationController < ActionController::Base
	
	def admin?
		unless current_user.email == ENV['ADMIN']
			redirect_to root_path
		end
	end

end
