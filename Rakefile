require 'bundler'
Bundler.setup

require 'jasmine-headless-webkit'

Jasmine::Headless::Task.new(:coffee) do |spec|
  spec.colors = true
  spec.keep_on_error = true
  spec.jasmine_config = 'spec/support/jasmine.yml'
end

task default: :coffee
