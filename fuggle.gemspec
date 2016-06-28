# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fuggle/version'

Gem::Specification.new do |spec|
  spec.name          = 'fuggle'
  spec.version       = Fuggle::VERSION
  spec.authors       = ['Sam Leavens']
  spec.email         = ['rbwsam@gmail.com']
  spec.summary       = 'Simple task automation tool.'
  spec.description   = 'Simple task automation tool with zero dependencies.'
  spec.homepage      = 'https://github.com/rbwsam/fuggle'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
end
