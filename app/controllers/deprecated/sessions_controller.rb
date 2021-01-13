class SessionsController < ApplicationController
	def new
		render :new #login form
	end

	def create
		# find a user by their username and password
		user = User.find_by_credentials(
			params[:user][:username],
			params[:user][:password]
		)
		# not using strong params, but keeps convention
		# two arguments (not one hash)

		if user
			# log the user in
			session[:session_token] = user.reset_session_token!
			# finish response
			redirect_to posts_url
		else
			flash.now[:errors] = ['Invalid credentials']
			render :new
		end
	end

	def destroy
		# log the user out
		current_user.reset_session_token!
		session[:session_token] = nil
        # break on both database and cookie side to be extra secure!
        if current_user
            render json: {}
        else
            render json: ["You need to log in"], status: 422
        end
	end

end