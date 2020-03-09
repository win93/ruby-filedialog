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

require "bundler/gem_tasks"
require "rake/extensiontask"
require_relative "deps/filedialogbuilddeps"

Rake::ExtensionTask.new "filedialog" do |ext|
  ext.lib_dir = "lib/filedialog"
end

task :compiledeps do
  FileDialog::BuildDeps.compile_deps
end

task :cleandeps do
  FileDialog::BuildDeps.clean_deps
end

Rake::Task["compile"].enhance([:compiledeps])
Rake::Task["clean"].enhance([:cleandeps])
