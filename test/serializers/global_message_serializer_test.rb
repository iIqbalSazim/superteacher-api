require 'test_helper'

class GlobalMessageSerializerTest < ActiveSupport::TestCase
    test 'should render correct attributes' do
        message_data = classroom_global_messages(:message_one)

        serialized_object = GlobalMessageSerializer.new.serialize(message_data)
        parsed_object = JSON.parse(serialized_object.to_json)

        assert_equal message_data[:text], parsed_object['text']
        assert_equal message_data[:id], parsed_object['id']
        assert_equal message_data[:classroom_id], parsed_object['classroom_id']
        assert_not_nil message_data.user.id
    end
end