# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "backerman"
  s.version     = "0.0.1"
  s.authors     = ["Shaun Dern"]
  s.email       = ["shaun@substantial.com"]
  s.homepage    = ""
  s.summary     = %q{Provision servers for your project with a single command. Use multi-stage}
  s.description = %q{Uses Chef-librarian and Chef-solo to provision servers defined for any stage}

  s.rubyforge_project = "backerman"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "minitest", "~> 2.12.0"
  s.add_development_dependency "minitest-capistrano", "~> 0.0.8"
  s.add_development_dependency "minitest-colorize", "~> 0.0.4"
  s.add_development_dependency "guard-minitest", "~> 0.5.0"

  s.add_dependency "capistrano", ">= 2.0.0"
end
