# frozen_string_literal: true

# Copyright (C) 2020  Alex Gittemeier
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

require_relative "lib/filedialog/version"

Gem::Specification.new do |spec|
  spec.name          = "filedialog"
  spec.version       = FileDialog::VERSION
  spec.license       = "GPL-3.0"
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
    `git ls-files --recurse-submodules -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.extensions    = ["ext/filedialog/extconf.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "os", "~> 1.0"
  spec.add_dependency "rake", "~> 13.0"
end
