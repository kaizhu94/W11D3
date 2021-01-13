class ApplicationController < ActionController::Base

    helper_method :current_user, :login?

    def current_user
        @current_user ||= User.find_by(session_token: session:[session_token])
    end

    def ensure_login
    end

    def login?
    end

    def login!
    end

    def logout!
    end
end
