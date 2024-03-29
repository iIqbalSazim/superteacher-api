ENV["RAILS_ENV"] ||= "test"

require "simplecov"
SimpleCov.start

require_relative "../config/environment"
require "rails/test_help"
require 'minitest/autorun'
require 'mocha/minitest'
require 'mocha'
require 'minitest/unit'
require 'minitest'
require 'json'
require 'shoulda/matchers'
require 'factory_bot_rails'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    # parallelize(workers: :number_of_processors)
    include FactoryBot::Syntax::Methods

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    # fixtures :all

    # Add more helper methods to be used by all tests here...
    include Shoulda::Matchers::ActiveModel
    include Shoulda::Matchers::ActiveRecord
  end

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :minitest
      with.library :rails
    end
  end

  class ActionController::TestCase
    def setup_controller_with_fake_user
      @fake_user = create(:user, :teacher)

      token_mock = mock

      token_mock.expects(:acceptable?).returns(true)
      token_mock.expects(:resource_owner_id).returns(@fake_user.id)

      @controller.stubs(:doorkeeper_token).returns(token_mock)
    end

    def setup_controller_with_fake_student_user
      @fake_user = create(:user, :student)

      token_mock = mock

      token_mock.expects(:acceptable?).returns(true)
      token_mock.expects(:resource_owner_id).returns(@fake_user.id)

      @controller.stubs(:doorkeeper_token).returns(token_mock)
    end
  end
end