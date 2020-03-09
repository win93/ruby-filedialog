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

require "mkmf"
require "os"

def add_cflags(str)
  $CFLAGS += " " + str
end

def add_include(str)
  $CFLAGS += " -I" + str
end

def add_libs(str)
  $LOCAL_LIBS += " " + str
end
alias add_static_lib add_libs

def pkg_config(*args)
  IO.popen(["pkg-config", *args], &read).chomp
end

def add_pkg(package)
  add_cflags(pkg_config(package, "--cflags"))
  add_libs(pkg_config(package, "--libs"))
end

project_root = File.join(__dir__, "../..")

add_include(File.join(project_root,
  "deps/nativefiledialog/src/include"))
add_static_lib(File.join(project_root,
  "deps/nativefiledialog/build/lib/Release/x64/libnfd.a"))

if OS.linux?
  add_pkg("gtk+-3.0")
elsif OS.mac?
  add_libs("-framework AppKit")
end

Dir.chdir(project_root) do
  system("rake compiledeps")
end

create_makefile "filedialog/filedialog"
