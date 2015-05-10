$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'vagrant-mosh/version'

Gem::Specification.new do |s|
  s.name        = 'vagrant-mosh'
  s.version     = VagrantPlugins::Mosh::VERSION
  s.author      = 'Alex Rodionov'
  s.email       = 'p0deje@gmail.com'
  s.homepage    = 'http://github.com/p0deje/vagrant-mosh'
  s.summary     = 'Use Mosh to connect to box'
  s.description = 'Vagrant plugin to use Mosh to connect to box'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = %w[lib]

  s.add_development_dependency 'rake'
end
