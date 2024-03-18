class ClassroomRepository < BaseRepository
    class << self
        def find_by_teacher_id(teacher_id)
            klass.where(teacher_id: teacher_id)
        end

        def find_by_student_id(student_id)
            klass.left_outer_joins(:classroom_students)
                .where(classroom_students: { student_id: student_id })
        end

        private

        def klass
            Classroom
        end
    end
end