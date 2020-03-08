#include <ruby.h>
#include <nfd.h>

static VALUE eFileDialogError;

static VALUE FileDialog_s_open_dialog(
	VALUE self, VALUE filter_list, VALUE default_path)
{
	nfdresult_t rc;
	nfdchar_t *strResult;
	VALUE result;

	Check_Type(filter_list, T_STRING);
	Check_Type(default_path, T_STRING);

	rc = NFD_OpenDialog(StringValueCStr(filter_list), StringValueCStr(default_path), &strResult);
	if (rc == NFD_ERROR)
		rb_raise(eFileDialogError, "%s", NFD_GetError());
	else if (rc == NFD_CANCEL)
		return Qnil;

	result = rb_str_new_cstr(strResult);
	free(strResult);
	return result;
}

static VALUE FileDialog_s_open_dialog_multi(
	VALUE self, VALUE filter_list, VALUE default_path)
{
	nfdresult_t rc;
	nfdpathset_t pathset;
	size_t pathsetCount;
	VALUE result;

	Check_Type(filter_list, T_STRING);
	Check_Type(default_path, T_STRING);

	rc = NFD_OpenDialogMultiple(StringValueCStr(filter_list), StringValueCStr(default_path), &pathset);
	if (rc == NFD_ERROR)
		rb_raise(eFileDialogError, "%s", NFD_GetError());
	else if (rc == NFD_CANCEL)
		return Qnil;

	pathsetCount = NFD_PathSet_GetCount(&pathset);
	result = rb_ary_new_capa(pathsetCount);

	for (int i = 0; i < pathsetCount; i++)
		rb_ary_push(result, rb_str_new_cstr(NFD_PathSet_GetPath(&pathset, i)));

	NFD_PathSet_Free(&pathset);
	return result;
}

static VALUE FileDialog_s_save_dialog(
	VALUE self, VALUE filter_list, VALUE default_path)
{
	nfdresult_t rc;
	nfdchar_t *strResult;
	VALUE result;

	Check_Type(filter_list, T_STRING);
	Check_Type(default_path, T_STRING);

	rc = NFD_SaveDialog(StringValueCStr(filter_list), StringValueCStr(default_path), &strResult);
	if (rc == NFD_ERROR)
		rb_raise(eFileDialogError, "%s", NFD_GetError());
	else if (rc == NFD_CANCEL)
		return Qnil;

	result = rb_str_new_cstr(strResult);
	free(strResult);
	return result;
}

static VALUE FileDialog_s_pick_folder(
	VALUE self, VALUE default_path)
{
	nfdresult_t rc;
	nfdchar_t *strResult;
	VALUE result;

	Check_Type(default_path, T_STRING);

	rc = NFD_PickFolder(StringValueCStr(default_path), &strResult);
	if (rc == NFD_ERROR)
		rb_raise(eFileDialogError, "%s", NFD_GetError());
	else if (rc == NFD_CANCEL)
		return Qnil;

	result = rb_str_new_cstr(strResult);
	free(strResult);
	return result;
}

void Init_filedialog() {
	VALUE mFileDialog = rb_define_module("FileDialog");
	eFileDialogError = rb_define_class_under(mFileDialog, "Error", rb_eStandardError);

	rb_define_module_function(mFileDialog, "open_dialog_native", FileDialog_s_open_dialog, 2);
	rb_define_module_function(mFileDialog, "open_dialog_multi_native", FileDialog_s_open_dialog_multi, 2);
	rb_define_module_function(mFileDialog, "save_dialog_native", FileDialog_s_save_dialog, 2);
	rb_define_module_function(mFileDialog, "pick_folder_native", FileDialog_s_pick_folder, 1);
}
