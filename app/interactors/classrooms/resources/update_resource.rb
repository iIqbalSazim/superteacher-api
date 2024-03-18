class Classrooms::Resources::UpdateResource < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[params resource_id].freeze

    RESOURCE_UPDATE_FAILED = "Failed to update resource"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        resource = ResourceRepository.find_by_id(resource_id)

        if resource.present?
            update_resource(resource)
        else
            context.fail!(
                message: RESOURCE_UPDATE_FAILED,
                status: :unprocessable_entity
            )
        end
    end

    private

    def update_resource(resource)
        if resource.assignment?
            updated_assignment = AssignmentRepository.update(resource.assignment, assignment_params(resource.id))

            unless updated_assignment.valid?
                context.fail!(
                    message: RESOURCE_UPDATE_FAILED,
                    status: :unprocessable_entity
                )
            end
        end

        updated_resource = ResourceRepository.update(resource, resource_params)

        if updated_resource.valid?
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