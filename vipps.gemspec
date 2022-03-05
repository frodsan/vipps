require_relative "lib/vipps/version"

Gem::Specification.new do |spec|
  spec.name = "vipps"
  spec.version = Vipps::VERSION
  spec.authors = ["Francesco Rodriguez"]
  spec.email = ["frodsan@me.com"]

  spec.summary = "Ruby wrapper around the Vipps API"
  spec.description = spec.summary
  spec.homepage = "https://github.com/frodsan/vipps"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = `git ls-files`.split("\n")
  spec.executables = spec.files.grep(%r{^exe/}).map { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 2.2"
end
