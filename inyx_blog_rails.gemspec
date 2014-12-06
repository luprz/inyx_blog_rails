$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "inyx_blog_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "inyx_blog_rails"
  s.version     = InyxBlogRails::VERSION
  s.authors     = ["TODO: gbrlmrllo"]
  s.email       = ["TODO: gbrlmrllo@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: InyxBlogRails is gem blog integrate to inyxmater"
  s.description = "TODO: Description of InyxBlogRails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.4"
  s.add_dependency "simple_form"
  s.add_dependency "haml_rails"

  s.add_development_dependency "sqlite3"
end
