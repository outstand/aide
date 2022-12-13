# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aide/version'

Gem::Specification.new do |spec|
  spec.name          = "aide"
  spec.version       = Aide::VERSION
  spec.authors       = ["Ryan Schlesinger"]
  spec.email         = ["ryan@outstand.com"]

  spec.summary       = %q{A configuration helper for Diplomat}
  spec.description   = %q{Allows a user to mash up keys without multiple calls to Consul}
  spec.homepage      = "https://github.com/outstand/aide"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.3"
  spec.add_development_dependency "rake", "~> 13"

  spec.add_runtime_dependency 'diplomat'
end
