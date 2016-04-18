ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
  # order.
  fixtures :all
  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end
  # Log in a test user
  def log_in_as(user, options = {})
  	password = options[:password] || 'password'
  	remember_me = options[:remember_me] || '1'
  	if integration_test?
  		post login_path, session: {email: user.email,
  															 password: password,
  															 remember_me: remember_me}
  	else
  		seesion[:user_id] = user.user_id
  	end
  end
  
  # Returns true inside an integration test.
    def integration_test?
      defined?(post_via_redirect)
    end
  # Add more helper methods to be used by all tests here...
end