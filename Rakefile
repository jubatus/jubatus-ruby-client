require 'rubygems'
require 'bundler'
require 'simplecov' # for Ruby 1.9
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

# for Ruby 1.8
task :coverage do |coverage|
  FileList['test/jubatus_test/*/'].each do |engine_dir|
    system("rcov -o test/coverage -I lib:test  --exclude . --include-file lib/jubatus " + engine_dir + '/*.rb')
  end
end

task :default => [:build]
