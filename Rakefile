require 'rubygems'
require 'bundler'
require 'rake/testtask'
require 'ci/reporter/rake/test_unit'

Bundler::GemHelper.install_tasks

task :test do |test|
  # We can't test all engines at a time as they share
  # the same namespace for each config_data.
  FileList['test/jubatus_test/*/'].each do |engine_dir|
    Rake::TestTask.new(:test) do |t|
      t.libs << 'lib' << 'test'
      t.test_files = FileList[engine_dir + '/*.rb']
      t.verbose = true
    end
  end
end

task :default => [:build]
