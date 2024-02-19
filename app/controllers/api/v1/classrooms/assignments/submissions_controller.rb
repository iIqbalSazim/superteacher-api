class Api::V1::Classrooms::Assignments::SubmissionsController < BaseController

    def create
        result = Classrooms::Assignments::Submissions::CreateNewSubmissionFlow.call(classroom_id: params[:classroom_id],
                                                                                    params: submission_params,
                                                                                    resource_id: params[:assignment_id],
                                                                                    current_user: current_user)

        if result.success?
            serialized_submission = SubmissionSerializer.new.serialize(result.submission)

            render json: { submission: serialized_submission }, status: :ok
        else
            render json: { message: result.message }, status: :unprocessable_entity
        end 
    end

    def destroy
        result = Classrooms::Assignments::Submissions::DeleteSubmissionFlow.call(classroom_id: params[:classroom_id],
                                                                                resource_id: params[:assignment_id],
                                                                                submission_id: params[:id],
                                                                                current_user: current_user)

        if result.success?
            render status: :ok
        else
            render json: { message: result.message }, status: result.status
        end
    end

    private 
    
    def submission_params
        params.require(:submission).permit(
            :student_id,
            :assignment_id,
            :submitted_on,
            :url,
            :submission_status
        )
    end

    def resource_model
        [:classrooms, :assignments, :submission]
    end
end