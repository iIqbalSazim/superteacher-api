class ClassroomStudentRepository < BaseRepository
    class << self
        def find_by_classroom_and_student_id(classroom_id, student_id)
            klass.find_by(classroom_id: classroom_id, student_id: student_id)
        end

        private

        def klass
            ClassroomStudent
        end
    end
end