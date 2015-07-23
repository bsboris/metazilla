# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metazilla/version'

Gem::Specification.new do |spec|
  spec.name          = "metazilla"
  spec.version       = Metazilla::VERSION
  spec.authors       = ["Eugene Likholetov"]
  spec.email         = ["bsboris@gmail.com"]

  spec.summary       = %q{Simple metatags and page titles for Rails.}
  spec.description   = %q{Simple metatags and page titles for Rails.}
  spec.homepage      = "https://github.com/bsboris/metazilla"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "actionview", ">= 3.0.0"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
