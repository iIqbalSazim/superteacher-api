class Classrooms::Assignments::Submissions::DeleteSubmission < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[submission_id resource_id].freeze

    DELETE_FAILED = "Failed to delete submission"
    DOES_NOT_EXIST = "Submission does not exist"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        submission = Submission.find_by(id: submission_id, assignment_id: resource_id)

        if submission
            delete_submission(submission)
        else
            context.fail!(
                message: DOES_NOT_EXIST,
                status: :unprocessable_entity
            )
        end
    end

    private

    def delete_submission(submission)
        context.fail!(
            message: DELETE_FAILED,
            status: :unprocessable_entity
        ) unless submission.destroy
    end
end