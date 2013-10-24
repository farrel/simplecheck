# -*- encoding: utf-8 -*-
$:.unshift File.expand_path('../lib', __FILE__)
require 'simplecheck/version'

Gem::Specification.new do |s|
  s.name        = 'simplecheck'
  s.version     = Simplecheck::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Farrel Lifson']
  s.email       = ['farrel.lifson@aimred.com']
  s.homepage    = 'http://www.aimred.com/projects/simplecheck'
  s.summary     = 'Simple property checking for Ruby'
  s.description = 'Simple property checking for Ruby'

  s.rubyforge_project = 'rcap'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.extra_rdoc_files = ['README.md','CHANGELOG.md']
end