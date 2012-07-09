$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "suj/commentable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "suj-commentable"
  s.version     = Suj::Commentable::VERSION
  s.authors     = ["Horacio Sanson"]
  s.email       = ["horacio@skillupjapan.co.jp"]
  s.homepage    = ""
  s.summary     = "Simple mongoid comments plugin."
  s.description = "Adds comments to any mongoid class."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.6"
  s.add_dependency "mongoid"
  s.add_dependency "bson_ext"
  s.add_dependency "kaminari"
  s.add_dependency "mongoid-tree"
  s.add_dependency "mongoid_rateable"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "mongoid"
  s.add_development_dependency "bson_ext"
  s.add_development_dependency "kaminari"
  s.add_development_dependency "mongoid-tree"
  s.add_development_dependency "mongoid_rateable"
end
