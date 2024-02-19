class User < ApplicationRecord
    has_secure_password
    enum role: { student: 'student', teacher: 'teacher' }
    enum gender: { Male: 'Male', Female: 'Female' }

    has_one :student_profile, foreign_key: 'student_id', dependent: :destroy
    has_one :teacher_profile, foreign_key: 'teacher_id', dependent: :destroy

    has_many :classroom_global_messages

    validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
    validates :password_digest, presence: true, length: { maximum: 255 }
    validates :first_name, presence: true, length: { maximum: 255 }
    validates :last_name, presence: true, length: { maximum: 255 }
    validates :phone_number, length: { maximum: 11 }
    validates :gender, presence: true
    validates :role, presence: true

    def student?
        self[:role] == "student"
    end

    def teacher?
        self[:role] == "teacher"
    end
end
