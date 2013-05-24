require "rubygems"
require "rspec"
require "capybara/rspec"
require "selenium/client"

# Add the 'spec' path in the load path
spec_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(spec_dir)
$LOAD_PATH.unshift("#{spec_dir}/support")

require 'configuration'
require 'matchers'

# Require all ruby files in the 'support' folder
Dir[File.join(spec_dir, "support/**/*.rb")].each {|f| require f}

test_env = ENV['TEST_ENV'] || 'server1'

configuration = Configuration.load_from_file("#{File.dirname(__FILE__)}/configuration.yaml")[test_env.to_sym]
raise "No configuration found for environment '#{test_env}'" if configuration == nil

# RSpec config here
RSpec.configure do |config|

  Capybara.configure do |capybara|
    capybara.run_server = false
    capybara.app_host = configuration.app_host
    capybara.default_driver = :selenium
    capybara.default_wait_time = 15
  end

  Features::SessionHelper.configure do |session_config|
    session_config.users = configuration.users
  end

  config.include Capybara::DSL
  config.include Features::SessionHelper
  config.include Page::Pages
  config.include Page::PageHelper

  config.after(:each) do
    Page::Pages::clear
  end

  Capybara.register_driver :selenium_with_long_timeout do |app|
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 240
    Capybara::Driver::Selenium.new(app, :browser => :firefox, :http_client => client)
  end

  Capybara.javascript_driver = :selenium_with_long_timeout
end