# frozen_string_literal: true

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

create_makefile "filedialog/filedialog"
