require_relative "./lib/highwayhash/version"

Gem::Specification.new do |s|
  s.name    = "highwayhash"
  s.version = Highwayhash::VERSION
  s.summary = "Highwayhash Ruby C Extension"
  s.author  = "James Cook"
  s.platform = Gem::Platform::RUBY
  s.homepage = "https://github.com/jamescook/highwayhash"

  s.files = Dir.glob("lib/**/*.{rb}")

  s.licenses << "MIT"

  s.add_dependency "ffi", "~> 1.9"
  s.add_development_dependency "minitest", "~> 5"
  s.required_ruby_version = '> 2.1'
end
