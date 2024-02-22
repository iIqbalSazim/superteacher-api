require 'test_helper'

class ClassroomSerializerTest < ActiveSupport::TestCase
    test 'should render correct attributes' do
        classroom_data = classrooms(:math_classroom)

        serialized_object = ClassroomSerializer.new.serialize(classroom_data)
        parsed_object = JSON.parse(serialized_object.to_json)

        assert_equal classroom_data[:id], parsed_object['id']
        assert_equal classroom_data[:title], parsed_object['title']
        assert_equal classroom_data[:subject], parsed_object['subject']
        assert_equal classroom_data[:class_time], parsed_object['class_time']
        assert_equal classroom_data[:days], parsed_object['days']
        assert_not_nil classroom_data[:created_at]
        assert_not_nil classroom_data.teacher
    end
end