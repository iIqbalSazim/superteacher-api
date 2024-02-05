require 'test_helper'

class GetClassroomsStudentTest < ActiveSupport::TestCase
    test "successfully gets classrooms when correct params are passed" do
        student_id = User.find_by(role: "student").id
        result = Classrooms::GetClassroomsStudent.call(user_id: student_id)

        assert result.success?
        assert_not_nil result.classrooms
    end


    test "fails to get classrooms when incorrect params are passed" do
        student_id = Classroom.find_by(id: 100)

        result = Classrooms::GetClassroomsStudent.call(user_id: student_id)

        assert_not result.success?
        assert_not_nil result.error
    end
end