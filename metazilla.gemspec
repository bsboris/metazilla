# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "metazilla/version"

Gem::Specification.new do |spec|
  spec.name          = "metazilla"
  spec.version       = Metazilla::VERSION
  spec.authors       = ["Eugene Likholetov"]
  spec.email         = ["bsboris@gmail.com"]

  spec.summary       = "Simple metatags and page titles for Rails."
  spec.description   = "Simple metatags and page titles for Rails."
  spec.homepage      = "https://github.com/bsboris/metazilla"
  spec.license       = "MIT"

  spec.files         = Dir["LICENSE.txt", "README.md", "lib/**/*"]
  spec.test_files    = Dir["test/**/*.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "actionview", ">= 3.0.0"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
