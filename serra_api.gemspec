Gem::Specification.new do |s|
  s.name        = "serra_api"
  s.version     = "0.0.1"
  s.summary     = "Gem to communicatie with Serra's API!"
  s.description = "Gem to communicatie with Serra's API!"
  s.authors     = ["Manish Valechha"]
  s.email       = "manish@getserra.com"
  s.files       = Dir["{app,config,lib}/**/*", "CHANGELOG.md", "README.md"]
  s.homepage    =
    "https://rubygems.org/gems/serra_api"
  s.license       = "MIT"
  s.add_dependency("oauth2", "~> 2.0.9")
end