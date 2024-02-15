class Classrooms::Exams::CreateNewExam < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[params].freeze

    SCHEDULE_EXAM_FAILED = "Failed to schedule exam"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        new_exam = Exam.new(params)

        if new_exam.save
            context.exam = new_exam
        else
            context.fail!(
                message: SCHEDULE_EXAM_FAILED,
                status: :unprocessable_entity
            )
        end
    end
end