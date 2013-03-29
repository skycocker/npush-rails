$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "npush-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "npush-rails"
  s.version     = Npush::VERSION
  s.authors     = ["Michał Siwek"]
  s.email       = ["mike21@aol.pl"]
  s.homepage    = "TODO"
  s.summary     = "Rails client gem for Npush server"
  s.description = "TODO: Description of Npush."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.11"

  s.add_development_dependency "sqlite3"
end
