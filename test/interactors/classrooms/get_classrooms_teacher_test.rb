require 'test_helper'

class GetClassroomsTeacherTest < ActiveSupport::TestCase
    test "successfully gets classrooms when correct params are passed" do
        teacher_id = User.find_by(role: "teacher").id
        result = Classrooms::GetClassroomsTeacher.call(user_id: teacher_id)

        assert result.success?
        assert_not_nil result.classrooms
    end


    test "fails to get classrooms when incorrect params are passed" do
        teacher_id = Classroom.find_by(id: 100)

        result = Classrooms::GetClassroomsTeacher.call(user_id: teacher_id)

        assert_not result.success?
        assert_not_nil result.error
    end
end