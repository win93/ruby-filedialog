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

require "filedialog/version"
require "filedialog/filedialog"

module FileDialog
  class Error < StandardError; end

  def self.open_dialog(filter_list, default_path, multiple: false)
    if multiple
      result = open_dialog_multi_native(
        filter_list.encode("UTF-8"), default_path.encode("UTF-8"))
      result.map{|x| x.force_encoding("UTF-8") }
    else
      result = open_dialog_native(
        filter_list.encode("UTF-8"), default_path.encode("UTF-8"))
      result.force_encoding("UTF-8")
    end
  end

  def self.save_dialog(filter_list, default_path)
    result = save_dialog_native(
      filter_list.encode("UTF-8"), default_path.encode("UTF-8"))
    result.force_encoding("UTF-8")
  end

  def self.pick_folder(default_path)
    pick_folder_native(default_path.encode("UTF-8")).force_encoding("UTF-8")
  end

  private_class_method :open_dialog_native
  private_class_method :open_dialog_multi_native
  private_class_method :save_dialog_native
  private_class_method :pick_folder_native
end
