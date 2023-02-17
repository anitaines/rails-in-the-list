ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module TestInfoHelper
  def mark_test_start_time
    @start_time = Time.now
  end

  def record_test_duration
    puts ""
    puts ""
    puts "Test class:   #{self.class.name}"
    puts "Test method:  #{self.method_name}"
    puts "Duration:     #{Time.now - @start_time}"
  end
end

class ActiveSupport::TestCase
  include TestInfoHelper
end
