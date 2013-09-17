# -*- encoding: utf-8 -*-
$:.push File.expand_path("../spec", __FILE__)

Gem::Specification.new do |s|
  s.name        = "gollum_git_adapter_specs"
  s.version     = "0.0.1" 
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Bart Kamphorst, Dawa Ometto"]
  s.email       = ["repotag-dev@googlegroups.com"]
  s.homepage    = "https://github.com/repotag/gollum_git_adapter_specs"
  s.summary     = %q{Gollum Git adapter specs.}
  s.description = %q{Gollum Git adapter specs.}

  s.add_development_dependency "rspec", "2.13.0"

  s.files         = Dir['spec/**/*.rb'] + ["README.md", "Gemfile"]
  s.require_paths = ["spec"]
end

