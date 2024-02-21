ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'minitest/autorun'
require 'mocha/minitest'
require 'mocha'
require 'minitest/unit'
require 'minitest'
require 'json'
require 'shoulda/matchers'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

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
      @fake_user = users(:teacher_user)

      token = mock
      token.stubs(:acceptable?).returns(true)
      token.stubs(:resource_owner_id).returns(@fake_user.id)

      @controller.stubs(:doorkeeper_token).returns(token)
    end
  end
end