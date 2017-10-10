# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unicorn/prewarm/version'

Gem::Specification.new do |spec|
  spec.name          = 'unicorn-prewarm'
  spec.version       = Unicorn::Prewarm::VERSION
  spec.authors       = ['Michal Cichra']
  spec.email         = ['michal@3scale.net']
  spec.summary       = %q{Make requests to unicorn workers before they receive real traffic.}
  spec.description   = %q{To prewarm workers, warm caches and load everything before real requests.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z 2> /dev/null`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.1'

  spec.add_dependency 'unicorn'
end
