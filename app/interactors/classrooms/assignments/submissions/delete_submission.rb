class Classrooms::Assignments::Submissions::DeleteSubmission < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[submission_id assignment_id].freeze

    DELETE_FAILED = "Failed to delete submission"
    DOES_NOT_EXIST = "Submission does not exist"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        submission = SubmissionRepository.find_by_id(submission_id)

        if submission.present?
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
        id = submission.id
        if SubmissionRepository.destroy(submission)
            context.submission_id = id
        else
            context.fail!(
                message: DELETE_FAILED,
                status: :unprocessable_entity
            )
        end
    end
end