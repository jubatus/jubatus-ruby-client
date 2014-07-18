# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "jubatus"
  gem.description = "Jubatus is a distributed processing framework and streaming machine learning library. This is the Jubatus client in Ruby."
  gem.homepage    = "http://jubat.us"
  gem.summary     = "Jubatus Ruby client"
  gem.version     = File.read("VERSION").strip
  gem.authors     = ["PFI & NTT"]
  gem.email       = "jubatus@googlegroups.com"
  gem.has_rdoc    = false
  gem.license     = "MIT"

  files = `git ls-files`.split("\n") + Dir.glob("lib/jubatus/**/*.rb")
  excludes = ["patch/*", "generate.sh"]

  gem.files       = files.reject { |f| excludes.any? { |e| File.fnmatch(e, f) } }
  gem.test_files  = gem.files.grep(%r{^(test|spec|features)/})
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency "msgpack-rpc", "~> 0.5.1"
  gem.add_development_dependency "rake", ">= 0.9.2"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "ci_reporter"
end
