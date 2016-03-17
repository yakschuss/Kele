# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kele/version'

Gem::Specification.new do |spec|
  spec.name            = 'kele'
  spec.version         = '0.0.1'
  spec.date            = '2016-03-07'
  spec.summary         = 'Kele API Client'
  spec.description     = 'A client for the Bloc API'
  spec.authors         = ['Jack Schuss']
  spec.email           = 'jackschuss@gmail.com'
  spec.files           = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths   = ["lib"]
  spec.homepage        = 'http://rubygems.org/gems/kele'
  spec.license         = 'MIT'
  spec.add_runtime_dependency 'httparty', '~> 0.13'
  spec.version         = Kele::VERSION
  spec.summary         = %q{Wrapper for Bloc.io's API}
  spec.license         = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end


  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
