# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'face_detect/version'

Gem::Specification.new do |spec|
  spec.name          = "face_detect"
  spec.version       = FaceDetect::VERSION
  spec.authors       = ["Aidan Feldman"]
  spec.email         = ["aidan.feldman@gsa.gov"]

  spec.summary       = %q{Simple face detection}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "google-api-client", "~> 0.9.6"
  spec.add_development_dependency "googleauth", "~> 0.5.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 2.0"
end
