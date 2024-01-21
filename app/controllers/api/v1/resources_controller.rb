class Api::V1::ResourcesController < ApplicationController
    include Panko
    before_action :authorize_resource_actions, only: [:create_resource]

    def get_resources
        result = Resources::GetResources.call(classroom_id: params[:classroom_id])

        if result.success?
            serialized_resources = ArraySerializer.new(result.resources, each_serializer: ResourceSerializer).to_a
            render json: { resources: serialized_resources, message: "Resources fetched successfully" }
        else
            render json: { error: result.error }, status: result.status
        end 
    end

    def create_resource
        result = Resources::CreateNewResourceFlow.call(resource: resource_params, classroom_id: resource_params[:classroom_id], current_user: current_user)

        if result.success?
            serialized_resource = ResourceSerializer.new.serialize(result.resource)
            render json: { resource: serialized_resource, message: "Resource created successfully" }
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    private 
    
    def resource_params
        params.require(:resource).permit(:title, :description, :resource_type, :url, :classroom_id)
    end

    def authorize_resource_actions
        if action_name == 'create_resource'
            authorize :resource, :create_resource?
        end
    end
end