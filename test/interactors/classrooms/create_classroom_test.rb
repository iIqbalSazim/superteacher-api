require 'test_helper'

class CreateClassroomTest < ActiveSupport::TestCase
    test "successfully creates classroom when correct params are passed" do
        classroom_params = { title: "Test class", subject: "Chemistry", meet_link: "https://example.com", class_time: "2000-01-01T12:00:00Z", days: ["Sunday", "Monday"] }
        teacher_id = 1

        result = Classrooms::CreateClassroom.call(classroom_params: classroom_params, teacher_id: teacher_id)

        assert result.success?
        assert_not_nil result.new_classroom
    end


    test "fails to create classroom when incorrect params are passed" do
        result = Classrooms::CreateClassroom.call(teacher_id: 1, classroom_params: {})

        assert_not result.success?
        assert_not_nil result.error
    end
end