require 'test_helper'

class ProfileSerializerTest < ActiveSupport::TestCase

    test 'should render correct attributes if user is a teacher' do
        teacher = create(:user, :teacher)
        teacher_profile = build_stubbed(:teacher_profile, teacher: teacher)

        serialized_object = ProfileSerializer.new.serialize(teacher_profile)
        parsed_object = JSON.parse(serialized_object.to_json)

        assert_equal teacher_profile[:id], parsed_object["id"]
        assert_equal teacher_profile[:highest_education_level], parsed_object["role_specific_attributes"]["highest_education_level"]
        assert_equal teacher_profile[:major_subject], parsed_object["role_specific_attributes"]["major_subject"]
        assert_equal teacher_profile[:subjects_to_teach], parsed_object["role_specific_attributes"]["subjects_to_teach"]
    end

    test 'should render correct attributes if user is a student' do
        student = create(:user, :student)
        student_profile = build_stubbed(:student_profile, student: student)

        serialized_object = ProfileSerializer.new.serialize(student_profile)
        parsed_object = JSON.parse(serialized_object.to_json)

        assert_equal student_profile[:id], parsed_object["id"]
        assert_equal student_profile[:education], parsed_object["role_specific_attributes"]["education"]
        assert_equal student_profile[:address], parsed_object["role_specific_attributes"]["address"]
    end
end
