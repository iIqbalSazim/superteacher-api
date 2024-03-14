FactoryBot.define do
    factory :exam do
        sequence(:title) { |n| "Exam #{n}" }
        classroom_id { 1 }
        description { "This is the test exam 1" }
        date { "2024-02-22" }

        trait :math_exam do
            title { "Math exam 1" }
        end
    end
end
