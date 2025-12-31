import 'dart:io';

class FileItemModel {
  final String titleFile;
  String? aboutFile;
  final void Function()? onTap;
  final File? file;

  FileItemModel({
    required this.titleFile,
    this.aboutFile,
    this.onTap,
    this.file,
  });
}
