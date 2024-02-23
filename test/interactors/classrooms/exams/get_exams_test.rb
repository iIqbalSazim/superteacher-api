require 'test_helper'

class Classrooms::Exams::GetExamsTest < ActiveSupport::TestCase

    test "should get exams by classroom_id" do
        classroom_id = classrooms(:math_classroom).id

        existing_exams = [exams(:math_exam_one)]

        result = Classrooms::Exams::GetExams.call(classroom_id: classroom_id)

        assert result.success?
        assert_equal existing_exams, result.exams
    end

    test "should return empty array if no resources" do
        classroom_id = classrooms(:empty_classroom).id

        result = Classrooms::Exams::GetExams.call(classroom_id: classroom_id)

        assert result.success?
        assert_equal [], result.exams
    end
end
