class Api::V1::Classrooms::ResourcesController < BaseController

    def index
        result = Classrooms::Resources::GetResourcesFlow.call(classroom_id: params[:classroom_id],
                                                              current_user: current_user)

        if result.success?
            serialized_resources = ArraySerializer.new(result.resources, each_serializer: ResourceSerializer).to_a

            render json: { resources: serialized_resources }, status: :ok
        else
            render json: { message: result.message }, status: :unprocessable_entity
        end 
    end

    def create
        result = Classrooms::Resources::CreateNewResourceFlow.call(params: resource_params,
                                                                   classroom_id: resource_params[:classroom_id],
                                                                   current_user: current_user)

        if result.success?
            serialized_resource = ResourceSerializer.new.serialize(result.resource)

            render json: { resource: serialized_resource }, status: :ok
        else
            render json: { message: result.message }, status: result.status
        end
    end

    def update
        result = Classrooms::Resources::UpdateResourceFlow.call(params: resource_params,
                                                                classroom_id: params[:classroom_id],
                                                                resource_id: params[:id],
                                                                current_user: current_user)

        if result.success?
            serialized_resource = ResourceSerializer.new.serialize(result.resource)

            render json: { resource: serialized_resource }, status: :ok
        else
            render json: { message: result.message }, status: result.status
        end
    end

    def destroy
        result = Classrooms::Resources::DeleteResourceFlow.call(classroom_id: params[:classroom_id],
                                                                resource_id: params[:id],
                                                                current_user: current_user)

        if result.success?
            render status: :ok
        else
            render json: { message: result.message }, status: result.status
        end
    end

    private 
    
    def resource_params
        params.require(:resource).permit(
            :title,
            :description,
            :resource_type,
            :url,
            :due_date,
            :classroom_id,
        )
    end

    def resource_model
        [:classrooms, :resource]
    end
end