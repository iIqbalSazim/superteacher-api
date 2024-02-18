class Classrooms::Resources::UpdateResource < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[params resource_id].freeze

    RESOURCE_UPDATE_FAILED = "Failed to update resource"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        resource = Resource.find_by(id: resource_id)

        update_resource(resource)
    end

    private

    def update_resource(resource)
        if resource.update(resource_params)
            resource.assignment.update(assignment_params(resource.id)) unless resource.material?
            context.resource = resource
        else
            context.fail!(
                message: RESOURCE_UPDATE_FAILED,
                status: :unprocessable_entity
            )
        end
    end

    def resource_params
        params.except(:due_date, :classroom_id)
    end

    def assignment_params(resource_id)
        {
            :resource_id => resource_id,
            :due_date => params[:due_date]
        }
    end
end