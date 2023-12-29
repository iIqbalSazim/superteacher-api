class Api::V1::ClassroomsController < ApplicationController

    def get_classrooms
        result = Classrooms::GetClassrooms.call(user_id: current_user.id)

        if result.success?
            render json: { classrooms: result.classrooms, message: "Classrooms fetched successfully" }
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    def create_classroom
        result = Classrooms::CreateClassroom.call(classroom_params: classroom_params, teacher_id: current_user.id)

        if result.success?
            render json: { classroom: result.new_classroom, message: "Classroom generated successfully" }
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
end