FactoryBot.define do
    factory :student, class: User do
        sequence(:id)
        sequence(:email) { |n| "student#{n}@email.com" }
        password_digest { "password" }
        first_name { "Student" }
        last_name { "User" }
        gender { "Male" }
        role { "student" }
    end
end
