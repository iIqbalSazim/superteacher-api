class StudentProfileRepository < BaseRepository
    class << self
        def find_by_student_id(student_id)
            klass.find_by(student_id: student_id)
        end

        private

        def klass
            StudentProfile
        end
    end
end