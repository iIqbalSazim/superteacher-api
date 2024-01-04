class Api::V1::ClassroomsController < ApplicationController
    include Panko
    before_action :authorize_create_classroom, only: [:create_classroom]

    def get_classrooms
        case current_user.role
        when "student"
            result = Classrooms::GetClassroomsStudent.call(user_id: current_user.id)
        when "teacher"
            result = Classrooms::GetClassroomsTeacher.call(user_id: current_user.id)
        end

        if result.success?
            serialized_classrooms = ArraySerializer.new(result.classrooms, each_serializer: ClassroomSerializer).to_a

            render json: { classrooms: serialized_classrooms, message: "Classrooms fetched successfully" }
        else
            render json: { error: result.error }, status: result.status
        end
    end

    def create_classroom
        result = Classrooms::CreateClassroom.call(classroom_params: classroom_params, teacher_id: current_user.id)

        if result.success?
            serialized_classroom = ClassroomSerializer.new.serialize(result.new_classroom)
            render json: { classroom: serialized_classroom, message: "Classroom generated successfully" }
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    def classroom_params
        params.require(:classroom).permit(
            :teacher_id,
            :title,
            :subject,
            :class_time,
            days: []
        )
    end

    private

    def authorize_create_classroom
        authorize :classroom, :create_classroom?
    end
end