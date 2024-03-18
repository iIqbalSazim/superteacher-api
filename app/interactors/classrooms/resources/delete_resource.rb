class Classrooms::Resources::DeleteResource < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[resource_id].freeze

    RESOURCE_DELETE_FAILED = "Failed to delete resource"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        resource = ResourceRepository.find_by_id(resource_id)

        context.fail!(
            message: RESOURCE_DELETE_FAILED,
            status: :unprocessable_entity
        ) unless resource.destroy
    end
end
