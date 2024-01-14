class Resources::GetResources
  include Interactor

    def call
        classroom_id = context.classroom_id

        all_resources = Resource.where(classroom_id: classroom_id)

        if all_resources.present?
            context.resources = all_resources
        else
            context.fail!(
                error: "Resources not found",
                message: "No resources found for the classroom",
                status: :unprocessable_entity
            )
        end
    end
end
