# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'
require 'twitter'
# require_relative "twitter.yaml"

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')


twitter_path = APP_ROOT.join('config', 'twitter.yml')
YAML.load(File.open(twitter_path)).each do |k,v|
  ENV[k.to_s] = v
end 

Twitter.configure do |config|
  config.consumer_key = ENV['TWITTER_KEY']
  config.consumer_secret = ENV['TWITTER_SECRET']
  config.oauth_token = ENV['OAUTH_TOKEN']
  config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
end

# Twitter.configure do |config|
#   config.consumer_key = 'hljxf8HHtXHc7SSDa6G6bg'
#   config.consumer_secret = '4BxoQ0iYhB9Ydi3SwWbr9LSIBCjRyXE2BOvYrhSA'
#   config.oauth_token = '1426903309-Jvnsvox4kfGWsZr18Rc3nLumcosgJuj5JFL54AB'
#   config.oauth_token_secret = 'FUCMdA1jg4HhneMGUW29wjgCRp8Qa7o1zgElHIT74'
# end


