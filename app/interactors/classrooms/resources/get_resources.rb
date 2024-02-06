class Classrooms::Resources::GetResources < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[classroom_id].freeze

    RESOURCES_NOT_FOUND = "Resources not found"
    NO_RESOURCES_FOR_CLASSROOM = "No resources found for the classrooms"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        resources = Resource.where(classroom_id: classroom_id)

        context.resources = resources
    end
end
