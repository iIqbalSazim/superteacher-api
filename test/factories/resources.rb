FactoryBot.define do
    factory :resource do
        sequence(:title) { |n| "Resource #{n}" }
        description { "This is a test resource" }
        url { "http://example.com" }
        classroom
        resource_type { "assignment" }

        trait :assignment_resource do
            resource_type { "assignment" }
            association :assignment, strategy: :build
        end

        trait :material_resource do
            resource_type { "material" }
        end
    end
end
