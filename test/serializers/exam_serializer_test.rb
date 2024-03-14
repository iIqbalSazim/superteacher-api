require 'test_helper'

class ExamSerializerTest < ActiveSupport::TestCase

    test 'should render correct attributes' do
        classroom = create(:classroom)
        exam = create(:exam, classroom: classroom)

        serialized_object = ExamSerializer.new.serialize(exam)
        parsed_object = JSON.parse(serialized_object.to_json)

        assert_equal exam[:id], parsed_object['id']
        assert_equal exam[:title], parsed_object['title']
        assert_equal exam[:description], parsed_object['description']
        assert_equal exam[:classroom_id], parsed_object['classroom_id']
        assert_equal exam[:date], parsed_object['date']
    end
end
