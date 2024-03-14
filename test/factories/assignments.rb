FactoryBot.define do
    factory :assignment do
        sequence(:resource_id)
        due_date { "2024-01-01T12:00:00Z" }
    end
end
