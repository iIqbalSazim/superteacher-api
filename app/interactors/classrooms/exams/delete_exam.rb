class Classrooms::Exams::DeleteExam < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[exam_id].freeze

    EXAM_DELETE_FAILED = "Failed to delete exam"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        exam = Exam.find_by(id: exam_id)

        context.fail!(
            message: EXAM_DELETE_FAILED,
            status: :unprocessable_entity
        ) unless exam.destroy
    end
end
