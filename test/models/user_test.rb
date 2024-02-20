require "test_helper"

class UserTest < ActiveSupport::TestCase
    should validate_presence_of(:email)
    should validate_presence_of(:password_digest)
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:gender)
    should validate_presence_of(:role)

    test 'user is created with validations passing' do
        valid_user = User.new(
            email: 'valid@email.com',
            password: 'validPassword',
            first_name: 'validFirstName',
            last_name: 'validLastName',
            gender: 'Male',
            role: 'teacher',
        )

        assert valid_user.valid?
        assert_empty valid_user.errors
    end

    test 'user is not created with validations failing' do
        invalid_user = User.new(
            email: '',
            password: '',
            first_name: '',
            last_name: '',
            gender: '',
            role: '',
        )

        assert_not invalid_user.valid?
        assert_not_empty invalid_user.errors[:email]
        assert_not_empty invalid_user.errors[:password]
        assert_not_empty invalid_user.errors[:first_name]
        assert_not_empty invalid_user.errors[:last_name]
        assert_not_empty invalid_user.errors[:gender]
        assert_not_empty invalid_user.errors[:role]
    end

    test '#teacher_profile exists for teacher user' do
        user = users(:teacher_user)

        assert_not_nil user.teacher_profile
        assert_nil user.student_profile
    end

    test '#student_profile exists for student user' do
        user = users(:student_user)

        assert_not_nil user.student_profile
        assert_nil user.teacher_profile
    end
end