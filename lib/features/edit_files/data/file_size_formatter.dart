class FileSizeFormatter {
  static String formatFileSize(int bytes) {
    const kb = 1024;
    const mb = kb * 1024;
    const gb = mb * 1024;

    if (bytes >= gb) {
      return "${(bytes / gb).toStringAsFixed(1)} GB";
    } else if (bytes >= mb) {
      return "${(bytes / mb).toStringAsFixed(1)} MB";
    } else if (bytes >= kb) {
      return "${(bytes / kb).toStringAsFixed(1)} KB";
    } else {
      return "$bytes B";
    }
  }
}
