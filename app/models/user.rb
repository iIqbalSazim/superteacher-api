class User < ApplicationRecord
    enum role: { student: 'student', teacher: 'teacher' }

    has_one :student_profile, foreign_key: 'student_id', dependent: :destroy
    has_one :teacher_profile, foreign_key: 'teacher_id', dependent: :destroy

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :gender, presence: true
    validates :role, presence: true

    def authenticate(password)
        self.password == password
    end
end
