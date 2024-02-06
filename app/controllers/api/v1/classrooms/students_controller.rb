class Api::V1::Classrooms::StudentsController < BaseController

    def index
        result = ClassroomStudents::GetStudentsFlow.call(classroom_id: params[:classroom_id],
                                                         filter: params[:filter])

        if result.success?
            serialized_students = ArraySerializer.new(result.students, each_serializer: UserSerializer).to_a

            render json: { students: serialized_students }, status: :ok
        else
            render json: { error: result.error }, status: result.status
        end
    end
    
    def enroll
        result = ClassroomStudents::EnrollStudentFlow.call(student_id: classroom_student_params[:student_id],
                                                           classroom_id: params[:classroom_id],
                                                           current_user: current_user)

        if result.success?
            serialized_student = UserSerializer.new.serialize(result.student)

            render json: { student: serialized_student }, status: :ok
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    def remove
        result = ClassroomStudents::RemoveStudentFlow.call(student_id: classroom_student_params[:student_id],
                                                           classroom_id: params[:classroom_id],
                                                           current_user: current_user)

        if result.success?
            render json: { removed_student: result.removed_student }, status: :ok
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

    def resource_model
        [:classrooms, :student]
    end
end