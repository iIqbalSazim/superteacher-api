require "test_helper"

class RegistrationCodeRepositoryTest < ActiveSupport::TestCase
    test "success if the RegistrationCodeRepository extends base_repository" do
        assert_equal BaseRepository, RegistrationCodeRepository.superclass
    end

    test "#klass matches RegistrationCode model" do
        assert_equal RegistrationCode, RegistrationCodeRepository.send(:klass)
    end

    test "find_by_email should return a token if it exists" do
        token_one = create(:registration_code)

        result = RegistrationCodeRepository.find_by_email(token_one[:email])

        assert_equal token_one, result
    end

    test "find_by_email should return nil if token does not exist" do

        result = RegistrationCodeRepository.find_by_email("non@existent.com")

        assert_not result.present?
    end
end