class Api::V1::ClassroomStudentsController < ApplicationController

    def get_students
        result = ClassroomStudents::GetStudents.call(classroom_id: params[:classroom_id])

        if result.success?
            render json: { students: result.students, message: "Students fetched successfully" }
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    def enroll_student
        result = ClassroomStudents::EnrollStudent.call(params: classroom_student_params)

        if result.success?
            render json: { student: result.student, message: "Student enrolled successfully"}
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    def classroom_student_params
        params.require(:classroom_student).permit(
            :student_id,
            :classroom_id,
        )
    end
end