class Api::V1::ClassroomStudentsController < ApplicationController
    include Panko
        before_action :authorize_enroll_student, only: [:enroll_student]

    def get_students
        result = ClassroomStudents::GetStudents.call(classroom_id: params[:classroom_id])

        if result.success?
            serialized_students = ArraySerializer.new(result.students, each_serializer: UserSerializer).to_a

            render json: { students: serialized_students, message: "Students fetched successfully" }
        else
            render json: { error: result.error }, status: result.status
        end
    end

    def enroll_student
        result = ClassroomStudents::EnrollStudent.call(params: classroom_student_params)

        if result.success?
            ClassroomStudentMailer.with(student: result.student, classroom: result.classroom).enroll_student_email.deliver_later

            serialized_student = UserSerializer.new.serialize(result.student)
            render json: { student: serialized_student, message: "Student enrolled successfully"}
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    def remove_student
        puts params
        result = ClassroomStudents::RemoveStudent.call(params: classroom_student_params)

        if result.success?
            serialized_student = UserSerializer.new.serialize(result.student)
            render json: { removed_student: serialized_student, message: "Student removed from class successfully" }
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

    private

    def authorize_enroll_student
        authorize :classroom_student, :enroll_student?
    end
end