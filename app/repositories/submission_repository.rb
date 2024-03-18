class SubmissionRepository < BaseRepository
    class << self
        def find_by_student_and_assignment_id(student_id, assignment_id)
            klass.find_by(student_id: student_id, assignment_id: assignment_id)
        end

        private

        def klass
            Submission
        end
    end
end