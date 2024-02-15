class Classrooms::Exams::GetExams < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[classroom_id].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        exams = Exam.where(classroom_id: classroom_id)

        context.exams = exams
    end
end
