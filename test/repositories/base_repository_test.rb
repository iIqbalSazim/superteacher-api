require "test_helper"

class BaseRepositoryTest < ActiveSupport::TestCase
    test "exception raised when klass is being called from base repository" do
        exception = assert_raises(RuntimeError) do
            BaseRepository.create({})
        end

        assert_equal BaseRepository::KLASS_ERROR_MESSAGE, exception.message
    end
end