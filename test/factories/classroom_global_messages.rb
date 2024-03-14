FactoryBot.define do
    factory :classroom_global_message do
        user
        classroom
        text { "Test message" }
    end
end
