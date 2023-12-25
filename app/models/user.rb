class User < ApplicationRecord
    enum role: { student: 'student', teacher: 'teacher' }

    has_one :student_profile, foreign_key: 'student_id'
    has_one :teacher_profile, foreign_key: 'teacher_id'

    def authenticate(password)
        self.password == password
    end
end
