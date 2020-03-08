# frozen_string_literal: true

require_relative "lib/filedialog/version"

Gem::Specification.new do |spec|
  spec.name          = "filedialog"
  spec.version       = FileDialog::VERSION
  spec.authors       = ["Alex Gittemeier"]
  spec.email         = ["gittemeier.alex@gmail.com"]

  spec.summary = "A ruby wrapper for https://github.com/mlabbe/nativefiledialog"
  spec.homepage = "https://github.com/win93/ruby-filedialog"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/win93/ruby-filedialog"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem CHANGELOG.md URL here."

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.extensions    = ["ext/filedialog/extconf.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "os", "~> 1.0"
end
