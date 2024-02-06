class BaseController < ApplicationController
    include Pundit::Authorization
    include Panko

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    before_action :authorize_request, 
                  :authorize_resource

    private

    def authorize_request
        doorkeeper_authorize!
    end

    def authorize_resource
        authorize resource_model
    end

    def resource_model
        raise NotImplementedError, "resource_model method must be defined in subclasses"
    end

    def current_user
        @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def user_not_authorized
        render json: { message: "You are not authorized." }, status: :forbidden
    end
end
