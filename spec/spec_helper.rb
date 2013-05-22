# encoding: utf-8

unless ENV['RSPEC_ENV'] == 'guard'
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
    add_filter 'version.rb'
  end
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'rspec/mocks'
require 'vcr'
require 'fryfro'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

