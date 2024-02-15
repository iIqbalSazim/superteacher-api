class Classrooms::Resources::CreateNewResource < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[params].freeze

    RESOURCE_CREATION_FAILED = "Failed to create resource"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        new_resource = Resource.new(resource_params)

        save_resource(new_resource)
    end

    private

    def save_resource(resource)
        if resource.save
            resource.create_assignment(assignment_params(resource.id)) unless resource.material?
            context.resource = resource
        else
            context.fail!(
                message: RESOURCE_CREATION_FAILED,
                status: :unprocessable_entity
            )
        end
    end

    def resource_params
        params.except(:due_date)
    end

    def assignment_params(resource_id)
        {
            :resource_id => resource_id,
            :due_date => params[:due_date]
        }
    end
end