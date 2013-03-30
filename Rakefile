#!/usr/bin/env rake

require "bundler/gem_tasks"
require 'rspec/core'
require 'rspec/core/rake_task'

desc "Run Unit Specs Only"
RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.rspec_opts = %w[--profile --tag ~integration --tag ~slow]
end

desc "Run All Specs (including slow specs)"
RSpec::Core::RakeTask.new(:ci) do |spec|
    spec.rspec_opts = %w[--profile]
end
task :default => :ci
