class IndicatorPdfFile {
  final String filePath;
  final String fileName;

  const IndicatorPdfFile({required this.filePath, required this.fileName});

  factory IndicatorPdfFile.fromJson(Map<String, dynamic> json) {
    return IndicatorPdfFile(
      filePath: json['filePath'] as String? ?? '',
      fileName: json['fileName'] as String? ?? '',
    );
  }
}
