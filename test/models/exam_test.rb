require 'test_helper'

class ExamTest < ActiveSupport::TestCase
    should belong_to(:classroom)

    should validate_presence_of(:title)
    should validate_presence_of(:description)
    should validate_presence_of(:classroom_id)
    should validate_presence_of(:date)

    test "exam is created with validations passing" do
        valid_exam = Exam.new(
            title: "New exam",
            description: "New exam description",
            classroom_id: 1, 
            date: "20 Feb, 2024"
        )

        assert valid_exam.valid?
        assert_empty valid_exam.errors
    end

    test "exam fails to create with validations failing" do
        invalid_exam = Exam.new

        assert_not invalid_exam.valid?
        assert_not_empty invalid_exam.errors[:title]
        assert_not_empty invalid_exam.errors[:description]
        assert_not_empty invalid_exam.errors[:classroom_id]
        assert_not_empty invalid_exam.errors[:date]
    end
end
