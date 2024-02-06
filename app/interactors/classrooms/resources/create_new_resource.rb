class Classrooms::Resources::CreateNewResource < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[resource_params].freeze

    RESOURCE_CREATION_FAILED = "Failed to create resource"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params(REQUIRED_PARAMS)

        new_resource = Resource.new(resource_params)

        save_resource(new_resource)
    end

    private

    def save_resource(resource)
        if resource.save
            context.resource = resource
        else
            context.fail!(
                message: RESOURCE_CREATION_FAILED,
                status: :unprocessable_entity
            )
        end
    end
end