FactoryBot.define do
    factory :student_profile do
        address { "Test" }
        education do
            {
                level: "University",
                english_bangla_medium: "",
                class_level: "",
                degree_level: "Bachelors",
                semester_year: "2023"
            }
        end
    end
end