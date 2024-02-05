require 'test_helper'

class ValidateClassroomTeacherTest < ActiveSupport::TestCase
    test "does not fail if correct params are passed" do
        classroom = Classroom.find_by(teacher_id: 1)
        current_user = User.find_by(id: 1)

        result = Shared::ValidateClassroomTeacher.call(classroom: classroom, current_user: current_user)

        assert result.success?
    end

    test "fails if incorrect params are passed" do
        classroom = Classroom.find_by(teacher_id: 1)
        current_user = User.find_by(id: 2)

        result = Shared::ValidateClassroomTeacher.call(classroom: classroom, current_user: current_user)

        assert_not result.success?
    end
end