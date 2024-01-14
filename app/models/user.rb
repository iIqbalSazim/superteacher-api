class User < ApplicationRecord
    enum role: { student: 'student', teacher: 'teacher' }
    enum gender: { Male: 'Male', Female: 'Female' }

    has_one :student_profile, foreign_key: 'student_id', dependent: :destroy
    has_one :teacher_profile, foreign_key: 'teacher_id', dependent: :destroy

    validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
    validates :password, presence: true, length: { maximum: 255 }
    validates :first_name, presence: true, length: { maximum: 255 }
    validates :last_name, presence: true, length: { maximum: 255 }
    validates :gender, presence: true
    validates :role, presence: true

    def authenticate(password)
        self.password == password
    end
end
