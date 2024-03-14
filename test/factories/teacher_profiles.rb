FactoryBot.define do
    factory :teacher_profile do
        highest_education_level { "Masters" }
        major_subject { "Math" }
        subjects_to_teach { ["Physics", "Biology", "Math"] }
    end
end