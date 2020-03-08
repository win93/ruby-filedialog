# frozen_string_literal: true

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
