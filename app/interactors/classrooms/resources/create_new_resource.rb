class Classrooms::Resources::CreateNewResource < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[params].freeze

    RESOURCE_CREATION_FAILED = "Failed to create resource"
    ASSIGNMENT_CREATION_FAILED = "Failed to create resource assignment"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        new_resource = ResourceRepository.new(resource_params)

        save_resource(new_resource)
    end

    private

    def save_resource(resource)
        if resource.save
            handle_assignment_creation(resource) unless resource.material?
            context.resource = resource
        else
            context.fail!(
                message: RESOURCE_CREATION_FAILED,
                status: :unprocessable_entity
            )
        end
    end

    def handle_assignment_creation(resource)
        assignment = AssignmentRepository.create(assignment_params(resource.id))

        unless assignment.persisted?
            ResourceRepository.destroy(resource)
            context.fail!(
                message: ASSIGNMENT_CREATION_FAILED,
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