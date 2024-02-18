class Classrooms::Exams::UpdateExam < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[params exam_id].freeze

    EXAM_UPDATE_FAILED = "Failed to update exam"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        exam = Exam.find_by(id: exam_id)

        if exam.update(exam_params)
            context.exam = exam
        else
            context.fail!(
                message: EXAM_UPDATE_FAILED,
                status: :unprocessable_entity
            )
        end
    end

    private 

    def exam_params
        params.except(:classroom_id)
    end
end