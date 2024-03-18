class ExamRepository < BaseRepository
    class << self
        private

        def klass
            Exam
        end
    end
end