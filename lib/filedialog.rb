# frozen_string_literal: true

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
