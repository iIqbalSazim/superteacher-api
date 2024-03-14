FactoryBot.define do
    factory :user do
        sequence(:email) { |n| "user#{n}@example.com" }
        password { "password" }
        first_name { "John" }
        last_name { "Doe" }
        gender { "Male" }
        role { "student" }
        phone_number { "01726252782" }

        trait :teacher do
            role { "teacher" }
            phone_number { nil }
            association :teacher_profile, strategy: :build
        end

        trait :student do
            association :student_profile, strategy: :build
        end

        trait :math_teacher do
            first_name { "Teacher" }
            last_name { "User" }
            role { "teacher" }
        end

        trait :biology_teacher do
            first_name { "Teacher" }
            last_name { "User 2" }
            role { "teacher" }
        end

        trait :empty_classroom_teacher do
            first_name { "Teacher" }
            last_name { "User 3" }
            gender { "Female" }
            role { "teacher" }
        end

        trait :math_student do
            first_name { "Student" }
            last_name { "User" }
            role { "student" }
        end

        trait :math_student_two do
            first_name { "Math" }
            last_name { "User" }
            gender { "Female" }
            role { "student" }
        end

        trait :unenrolled_student do
            first_name { "Student" }
            last_name { "User" }
            role { "student" }
        end
    end
end