require 'test_helper'

class Classrooms::Exams::GetExamsTest < ActiveSupport::TestCase

    test "should get exams by classroom_id" do
        classroom = create(:classroom)

        exam_1, exam_2 = create_list(:exam, 2, classroom: classroom)

        result = Classrooms::Exams::GetExams.call(classroom_id: classroom.id)

        assert result.success?
        assert_equal [exam_1, exam_2], result.exams
    end

    test "should return empty array if no resources" do
        classroom = create(:classroom)

        result = Classrooms::Exams::GetExams.call(classroom_id: classroom.id)

        assert result.success?
        assert_equal [], result.exams
    end
end
