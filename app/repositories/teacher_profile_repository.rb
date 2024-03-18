class TeacherProfileRepository < BaseRepository
    class << self
        def find_by_teacher_id(teacher_id)
            klass.find_by(teacher_id: teacher_id)
        end

        private

        def klass
            TeacherProfile
        end
    end
end