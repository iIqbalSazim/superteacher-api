class ApplicationController < ActionController::API
    include Pundit::Authorization
    before_action :doorkeeper_authorize!

    rescue_from Pundit::NotAuthorizedError, with: :handle_not_authorized

    private

    def current_user
        @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def handle_not_authorized
        render json: { message: "You are not authorized" }, status: :forbidden
    end
end
