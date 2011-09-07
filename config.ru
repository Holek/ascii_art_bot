require "bundler/setup"
Bundler.require(:default, :production)
require 'artii'
require 'artii/figlet'
require File.join(File.dirname(__FILE__), "ascii_art_bot.rb")

use Rack::CommonLogger
map '/ascii_art_bot' do
  run AsciiArtBot
end