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
require "os"

NFD_BUILD_LOCATIONS = {
  linux: "build/gmake_linux",
  macos: "build/gmake_macosx",
  windows: "build/gmake_windows"
}.freeze

PLATFORM =
  if OS.linux? then :linux
  elsif OS.mac? then :macos
  elsif OS.windows? then :windows
  else :other
  end

Rake::ExtensionTask.new "filedialog" do |ext|
  ext.lib_dir = "lib/filedialog"
end

deps_folder = File.expand_path("deps", __dir__)

nfd_build = File.join("nativefiledialog", NFD_BUILD_LOCATIONS[PLATFORM])

# Manually run by extconf.rb because bundler doesn't run rake at all
task :compiledeps do
  Dir.chdir(File.join(deps_folder, nfd_build)) do
    system("make -w")
  end
end

task :cleandeps do
  Dir.chdir(File.join(deps_folder, nfd_build)) do
    system("make -w clean")
  end
end

Rake::Task["clean"].enhance([:cleandeps])
