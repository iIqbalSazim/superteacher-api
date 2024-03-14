FactoryBot.define do
    factory :classroom_student do
        association :student, factory: :user, role: :student
        association :classroom
    end
end
