require 'test_helper'

class MailEnrolledStudentsTest < ActiveSupport::TestCase
    include ActiveJob::TestHelper

    test "successfully enqueues resource mailer when correct params are passed" do
        resource = Resource.find_by(classroom_id: 1)
        classroom = Classroom.find_by(id: 1)

        assert_enqueued_jobs 0

        result = Resources::MailEnrolledStudents.call(classroom: classroom, resource: resource)

        assert_enqueued_jobs classroom.students.length
    end


    test "does not enqueue when incorrect params are passed" do 
        result = Resources::MailEnrolledStudents.call

        assert_enqueued_jobs 0
    end
end