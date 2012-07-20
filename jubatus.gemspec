# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "jubatus"
  gem.description = "Jubatus client for Ruby compatible with Jubatus 0.3.1"
  gem.homepage    = "https://github.com/jubatus/jubatus-ruby-client"
  gem.summary     = gem.description
  gem.version     = File.read("VERSION").strip
  gem.authors     = ["Jubatus Team"]
  gem.email       = "jubatus@googlegroups.com"
  gem.has_rdoc    = false
  #gem.platform    = Gem::Platform::RUBY
  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency "msgpack-rpc", "~> 0.4.5"
  gem.add_development_dependency "rake", ">= 0.9.2"
end
