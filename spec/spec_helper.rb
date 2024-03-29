require "bundler/setup"
Bundler.require(:default, :test)

require File.expand_path("../ascii_art_bot.rb", File.dirname(__FILE__))

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

RSpec::Matchers.define :have_matches_for do |*expected|
  match do |actual|
    expected.all? { |e| actual.class.class_variable_get("@@matches").include?(e) }
  end
end