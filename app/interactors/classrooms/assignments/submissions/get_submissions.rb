class Classrooms::Assignments::Submissions::GetSubmissions < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[assignment_id].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        submissions = Submission.where(assignment_id: assignment_id)

        context.submissions = submissions
    end
end
