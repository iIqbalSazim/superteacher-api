class Classrooms::Assignments::Submissions::CreateNewSubmission < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[params].freeze

    SUBMISSION_FAILED = "Failed to create submission"
    EXISTING_SUBMISSION_ERROR = "You have already submitted. Please delete the previous submission and try again."

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        existing_submission = SubmissionRepository.find_by_student_and_assignment_id(params[:student_id], params[:assignment_id])

        if existing_submission.present?
            context.fail!(
                message: EXISTING_SUBMISSION_ERROR,
                status: :unprocessable_entity
            )
        else
            create_new_submission
        end
    end

    private

    def create_new_submission
        new_submission = SubmissionRepository.create(submission_params)

        if new_submission.persisted?
            context.submission = new_submission
        else
            context.fail!(
                message: SUBMISSION_FAILED,
                status: :unprocessable_entity
            )
        end
    end

    def submission_params
        params
    end
end