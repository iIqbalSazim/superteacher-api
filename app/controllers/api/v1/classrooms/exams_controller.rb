class Api::V1::Classrooms::ExamsController < BaseController

    def index
        result = Classrooms::Exams::GetExamsFlow.call(classroom_id: params[:classroom_id],
                                                      current_user: current_user)

        if result.success?
            serialized_exams = ArraySerializer.new(result.exams, each_serializer: ExamSerializer).to_a

            render json: { exams: serialized_exams }, status: :ok
        else
            render json: { message: result.message }, status: :unprocessable_entity
        end 
    end

    def create
        result = Classrooms::Exams::CreateNewExamFlow.call(params: exam_params,
                                                           classroom_id: exam_params[:classroom_id],
                                                           current_user: current_user)

        if result.success?
            serialized_exam = ExamSerializer.new.serialize(result.exam)

            render json: { exam: serialized_exam }, status: :ok
        else
            render json: { message: result.message }, status: result.status
        end
    end

    private 
    
    def exam_params
        params.require(:exam).permit(
            :title,
            :description,
            :classroom_id,
            :date
        )
    end

    def resource_model
        [:classrooms, :exam]
    end
end