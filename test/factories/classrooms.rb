FactoryBot.define do
    factory :classroom do
        sequence(:title) { |n| "Test class #{n}" }
        subject { "Math" }
        meet_link { "https://example.com" }
        class_time { "2000-01-01T12:00:00Z" }
        days { ["Sunday", "Tuesday"] }

        association :teacher, factory: :user

        trait :biology do
            subject { "Biology" }
        end

        trait :empty do
            subject { "Physics" }
            days { ["Sunday", "Monday", "Thursday"] }
        end
    end
end
