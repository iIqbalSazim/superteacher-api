FactoryBot.define do
    factory :registration_code do
        email { "test1@email.com" }
        is_used { false }
        code { "random" }

        trait :attempts_count_zero do
            email { "test2@email.com" }
            attempts_count { 0 }
        end
    end
end