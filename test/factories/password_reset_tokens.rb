FactoryBot.define do
    factory :password_reset_token do
        email { 'test@example.com' }
        code { '12345678' }
        is_used { false }

        trait :used do
            is_used { true }
        end
    end
end