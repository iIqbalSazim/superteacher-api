class Api::V1::ClassroomsController < BaseController

    def index
        result = Classrooms::GetClassroomsByUser.call(current_user: current_user)

        if result.success?
            serialized_classrooms = ArraySerializer.new(result.classrooms, each_serializer: ClassroomSerializer).to_a
            render json: { classrooms: serialized_classrooms }, status: :ok
        else
            render status: :unprocessable_entity
        end
    end

    def show
        result = Shared::FindClassroom.call(classroom_id: params[:id])

        if result.success?
            serialized_classroom = ClassroomSerializer.new.serialize(result.classroom)
            render json: { classroom: serialized_classroom }, status: :ok
        else
            render json: { message: result.message }, status: :unprocessable_entity
        end
    end

    def create
        result = Classrooms::CreateClassroom.call(classroom_params: classroom_params)

        if result.success?
            serialized_classroom = ClassroomSerializer.new.serialize(result.new_classroom)
            render json: { classroom: serialized_classroom }, status: :ok
        else
            render json: { message: result.message }, status: :unprocessable_entity
        end
    end

    def update
        result = Classrooms::UpdateClassroomFlow.call(classroom_params: classroom_params,
                                                      classroom_id: params[:id],
                                                      current_user: current_user)

        if result.success?
            serialized_classroom = ClassroomSerializer.new.serialize(result.updated_classroom)
            
            render json: { classroom: serialized_classroom }, status: :ok
        else
            render json: { message: result.message }, status: result.status
        end
    end

    def destroy
        result = Classrooms::DeleteClassroomFlow.call(classroom_id: params[:id],
                                                      current_user: current_user)

        if result.success?
            render json: { deleted_classroom_id: params[:id] }, status: :ok
        else
            render json: { message: result.message }, status: result.status
        end
    end

    private

    def classroom_params
        params.require(:classroom).permit(
            :teacher_id,
            :title,
            :subject,
            :class_time,
            :meet_link,
            days: []
        )
    end

    def resource_model
        :classroom
    end
end