require 'bundler'
Bundler.setup

require 'jasmine-headless-webkit'

Jasmine::Headless::Task.new(:coffee) do |spec|
  spec.colors = true
  spec.keep_on_error = true
  spec.jasmine_config = 'spec/support/jasmine.yml'
end

task release: :coffee do
  if system 'coffee -c -j rely-min lib/rely.coffee'
    system 'uglifyjs -ns --overwrite rely-min.js'
  end
end

task default: :coffee
