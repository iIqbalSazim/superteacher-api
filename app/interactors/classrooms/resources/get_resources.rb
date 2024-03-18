class Classrooms::Resources::GetResources < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[classroom_id].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        resources = ResourceRepository.find_by_classroom_id(classroom_id)

        context.resources = resources
    end
end
