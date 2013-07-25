$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cc_portal_wordpress_integration/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cc_portal_wordpress_integration"
  s.version     = CcPortalWordpressIntegration::VERSION
  s.authors     = ["Aaron Unger"]
  s.email       = ["aunger@concord.org"]
  s.homepage    = "http://concord.org"
  s.summary     = "A plugin for the CC Rails Portal for integrating with a custom Wordpress application"
  s.description = "A plugin for the CC Rails Portal for integrating with a custom Wordpress application"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  # s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.11"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
