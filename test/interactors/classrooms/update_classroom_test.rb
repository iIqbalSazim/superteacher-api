require 'test_helper'

class UpdateClassroomTest < ActiveSupport::TestCase
    test "successfully updates classroom when correct params are passed" do
        classroom = Classroom.find_by(id: 1)
        classroom_params = { title: "Updated test classroom" }

        result = Classrooms::UpdateClassroom.call(classroom: classroom, classroom_params: classroom_params )

        assert result.success?
    end


    test "fails to update classroom when incorrect params are passed" do
        classroom = Classroom.find_by(id: 1)

        result = Classrooms::UpdateClassroom.call(classroom: classroom, classroom_params: { title: ""})

        assert_not result.success?
        assert_not_nil result.error
    end
end