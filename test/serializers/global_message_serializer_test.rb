require 'test_helper'

class GlobalMessageSerializerTest < ActiveSupport::TestCase
    test 'should render correct attributes' do
        user = create(:user)
        classroom = create(:classroom)

        message = create(:classroom_global_message, classroom: classroom, user: user)

        serialized_object = GlobalMessageSerializer.new.serialize(message)
        parsed_object = JSON.parse(serialized_object.to_json)

        assert_equal message[:text], parsed_object['text']
        assert_equal message[:id], parsed_object['id']
        assert_equal message[:classroom_id], parsed_object['classroom_id']
        assert_not_nil message.user.id
    end
end