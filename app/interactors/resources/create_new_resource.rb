class Resources::CreateNewResource
    include Interactor

    def call
        resource = context.resource

        new_resource = Resource.new(resource)

        if new_resource.save
            context.resource = new_resource
        else
            context.fail!(
                error: "Something went wrong!",
                message: "User failed to save.",
                status: :internal_server_error
            )
        end
    end
end