require_relative 'lib/check_please_rspec_matcher/version'

Gem::Specification.new do |spec|
  spec.name          = "check_please_rspec_matcher"
  spec.version       = CheckPleaseRspecMatcher::VERSION
  spec.authors       = ["Sam Livingston-Gray"]
  spec.email         = ["geeksam@gmail.com"]

  spec.summary       = %q{Check for differences between two JSON strings (or Ruby data structures parsed from them), now in an RSpec matcher}
  spec.description   = %q{Check for differences between two JSON strings (or Ruby data structures parsed from them), now in an RSpec matcher}
  spec.homepage      = "https://github.com/RealGeeks/check_please_rspec_matcher"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "check_please", "~> #{CheckPleaseRspecMatcher::VERSION}" # this may turn out to be a bad idea?
  spec.add_dependency "rspec", "~> 3.9"
end