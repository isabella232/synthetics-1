require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'pry'

desc 'Run the gem specs'
RSpec::Core::RakeTask.new(:spec)

desc 'Load the gem'
task :environment do
  $LOAD_PATH << File.expand_path('../lib', __FILE__)
  require 'synthetics'
end

desc 'Start a console in the context of the Synthetics module'
task shell: :environment do
  Pry.start(Synthetics)
end

task default: :spec
