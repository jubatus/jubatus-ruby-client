require 'rubygems'
require 'bundler'
require 'simplecov' # for Ruby 1.9
require 'rake/testtask'
require 'ci/reporter/rake/test_unit'

Bundler::GemHelper.install_tasks

task :test do |test|
  Rake::TestTask.new(:test) do |t|
    t.libs << 'lib' << 'test'
    t.test_files = FileList['test/**/*.rb']
    t.verbose = true
  end
end

task :integration_test do |test|
  Rake::TestTask.new(:integration_test) do |t|
    t.libs << 'lib' << 'integration_test'
    t.test_files = FileList['integration_test/**/*.rb']
    t.verbose = true
  end
end

# for Ruby 1.8
task :coverage do |coverage|
  system("rcov -o test/coverage -I lib:test  --exclude . --include-file lib/jubatus --aggregate coverage.info test/**/*.rb")
end

task :default => [:build]
