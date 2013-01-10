# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knipper/version'

Gem::Specification.new do |gem|
  gem.name          = "knipper"
  gem.version       = Knipper::VERSION
  gem.authors       = ["Erwin Boskma"]
  gem.email         = ["erwin@datarift.nl"]
  gem.description   = %q{Ruby wrapper for the blink(1) C-library}
  gem.summary       = %q{Wraps the C-library that is available for the blink(1) USB status lights}
  gem.homepage      = "http://github.com/eboskma/knipper"
  
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "ffi", ['~> 1.2.0']
  
  gem.add_development_dependency "rspec", ['~> 2.12.0']
end
