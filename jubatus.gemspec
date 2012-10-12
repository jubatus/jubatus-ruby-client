# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "jubatus"
  gem.description = "Jubatus client for Ruby"
  gem.homepage    = "http://jubat.us"
  gem.summary     = gem.description
  gem.version     = File.read("VERSION").strip
  gem.authors     = ["Jubatus Team"]
  gem.email       = "jubatus@googlegroups.com"
  gem.has_rdoc    = false
  #gem.platform    = Gem::Platform::RUBY
  gem.license     = "MIT"

  files = `git ls-files`.split("\n")
  excluds = ["patch/*"]

  gem.files       = files.reject { |f| excluds.any? { |e| File.fnmatch(e, f) } }
  gem.test_files  = gem.files.grep(%r{^(test|spec|features)/})
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency "msgpack-rpc", "~> 0.4.5"
  gem.add_development_dependency "rake", ">= 0.9.2"
end
