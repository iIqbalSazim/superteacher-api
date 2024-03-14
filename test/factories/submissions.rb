FactoryBot.define do
    factory :submission do
        association :student, factory: :user
        association :assignment
        submitted_on { Date.today }
        url { "http://res.cloudinary.com/dvhqefik1/image/upload/v1708520310/xjqjxooaryvj79iemvva.png" }
        submission_status { "submitted" }
    end
end
