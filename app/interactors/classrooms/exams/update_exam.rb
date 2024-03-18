class Classrooms::Exams::UpdateExam < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[params exam_id].freeze

    EXAM_UPDATE_FAILED = "Failed to update exam"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        exam = ExamRepository.find_by_id(exam_id)

        if exam.present?
            handle_update_exam(exam)
        else
            context.fail!(
                message: EXAM_UPDATE_FAILED,
                status: :unprocessable_entity
            )
        end
    end

    private 

    def handle_update_exam(exam)
        updated_exam = ExamRepository.update(exam, exam_params)

        if updated_exam.valid?
            context.exam = exam
        else
            context.fail!(
                message: EXAM_UPDATE_FAILED,
                status: :unprocessable_entity
            )
        end
    end

    def exam_params
        params.except(:classroom_id)
    end
end