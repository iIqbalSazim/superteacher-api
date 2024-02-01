class Resources::CreateNewResource
    include Interactor

    def call
        resource = context.resource_params

        new_resource = Resource.new(resource)

        if new_resource.save
            context.resource = new_resource
        else
            context.fail!(
                error: "Something went wrong!",
                message: "Resource failed to save.",
                status: :internal_server_error
            )
        end
    end
end