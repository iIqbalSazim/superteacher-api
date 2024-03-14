class Api::V1::Classrooms::StudentsController < BaseController

    def index
        result = Classrooms::Students::GetStudentsFlow.call(classroom_id: params[:classroom_id],
                                                            filter: params[:filter],
                                                            current_user: current_user)

        if result.success?
            serialized_students = ArraySerializer.new(result.students, each_serializer: UserSerializer).to_a

            render json: { students: serialized_students }, status: :ok
        else
            render status: result.status
        end
    end
    
    def enroll
        result = Classrooms::Students::EnrollStudentFlow.call(student_id: student_params[:student_id],
                                                              classroom_id: params[:classroom_id],
                                                              current_user: current_user)

        if result.success?
            serialized_student = UserSerializer.new.serialize(result.student)

            render json: { student: serialized_student }, status: :ok
        else
            render json: { message: result.message }, status: result.status
        end
    end

    def remove
        result = Classrooms::Students::RemoveStudentFlow.call(student_id: student_params[:student_id],
                                                              classroom_id: params[:classroom_id],
                                                              current_user: current_user)

        if result.success?
            serialized_student = UserSerializer.new.serialize(result.removed_student)

            render json: { removed_student: serialized_student }, status: :ok
        else
            render json: { message: result.message }, status: result.status
        end
    end

    private

    def student_params
        params.require(:student).permit(
            :student_id,
            :classroom_id,
        )
    end

    def resource_model
        [:classrooms, :student]
    end
end