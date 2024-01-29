class Api::V1::ClassroomStudentsController < ApplicationController
    include Panko
    before_action :authorize_classroom_student, only: [:enroll_student, :remove_student]

    def get_students
        result = ClassroomStudents::GetEnrolledStudents.call(classroom_id: params[:classroom_id])

        if result.success?
            serialized_students = ArraySerializer.new(result.enrolled_students, each_serializer: UserSerializer).to_a

            render json: { students: serialized_students, message: "Students fetched successfully" }
        else
            render json: { error: result.error }, status: result.status
        end
    end

    def enroll_student
        result = ClassroomStudents::EnrollStudentFlow.call(params: classroom_student_params, classroom_id: classroom_student_params[:classroom_id], current_user: current_user)

        if result.success?
            serialized_student = UserSerializer.new.serialize(result.student)
            render json: { student: serialized_student, message: "Student enrolled successfully"}
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    def remove_student
        result = ClassroomStudents::RemoveStudentFlow.call(params: classroom_student_params, classroom_id: classroom_student_params[:classroom_id], current_user: current_user)

        if result.success?
            serialized_removed_student = UserSerializer.new.serialize(result.removed_student)
            render json: { removed_student: serialized_removed_student, message: "Student removed from class successfully" }
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    private

    def classroom_student_params
        params.require(:classroom_student).permit(
            :student_id,
            :classroom_id,
        )
    end

    def authorize_classroom_student
        if action_name == "enroll_student"
            authorize :classroom_student, :enroll_student?
        end
        if action_name = "remove_student"
            authorize :classroom_student, :remove_student?
        end
    end
end