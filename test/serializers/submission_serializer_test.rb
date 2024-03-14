require 'test_helper'

class SubmissionSerializerTest < ActiveSupport::TestCase

    def setup
        @submission = build_stubbed(:submission)
    end

    test 'should render correct attributes' do
        serialized_object = SubmissionSerializer.new.serialize(@submission)
        parsed_object = JSON.parse(serialized_object.to_json)

        assert_equal @submission[:id], parsed_object['id']
        assert_equal @submission[:student_id], parsed_object['student_id']
        assert_equal @submission[:assignment_id], parsed_object['assignment_id']
        assert_equal @submission[:url], parsed_object['url']
        assert_equal @submission[:submission_status], parsed_object['submission_status']
        assert_not_nil parsed_object['student_name']
        assert_not_nil parsed_object['created_at']
    end

    test "should serialize student_name" do
        serialized_object = SubmissionSerializer.new.serialize(@submission)
        parsed_object = JSON.parse(serialized_object.to_json)

        student = @submission.student

        expected_student_name = "#{ student.first_name } #{ student.last_name}"
        assert_equal expected_student_name, parsed_object['student_name']
    end
end