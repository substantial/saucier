# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "saucier"
  s.version     = "0.0.4"
  s.authors     = ["Shaun Dern"]
  s.email       = ["shaun@substantial.com"]
  s.homepage    = "http://github.com/substantial/saucier"
  s.summary     = %q{A Capistrano Extension that uses librarian and chef-solo for provisioning a server.}
  s.description = %q{A Capistrano Extension that uses librarian and chef-solo to track your project cookbook dependencies.
                     Use capistrano stages to quickly provision servers for your project. Version control your chef runlist, node configuration
                     and cookbook dependencies.
                    }

  s.rubyforge_project = "saucier"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake", "~> 0.9.2.2"
  s.add_development_dependency "minitest", "~> 2.12.0"
  s.add_development_dependency "minitest-capistrano", "~> 0.0.8"
  s.add_development_dependency "minitest-colorize", "~> 0.0.4"
  s.add_development_dependency "guard-minitest", "~> 0.5.0"

  s.add_dependency "capistrano", ">= 2.0.0"
end
