# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sawa/version'

Gem::Specification.new do |spec|
  spec.name          = "sawa"
  spec.version       = Sawa::VERSION
  spec.authors       = ["shouaya"]
  spec.email         = ["favaserver@gmail.com"]

  spec.summary       = %q{"rest system build with sawa"}
  spec.description   = %q{"https://github.com/shouaya/moa/blob/master/README.md"}
  spec.homepage      = "https://github.com/shouaya/sawagem"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = %w( sawa )
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "spreadsheet", '~> 1.1', '>= 1.1.4'
  spec.add_dependency "json", '~> 1.8', '>= 1.8.3'
  spec.add_dependency "mustache", '~> 1.0', '>= 1.0.5'
end
