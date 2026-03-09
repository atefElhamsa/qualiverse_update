class Doc {
  const Doc({
    required this.indicatorName,
    required this.criterionName,
    required this.fileName,
    required this.status,
    required this.uploadedBy,
    required this.year,
    required this.quarter,
    required this.month,
    required this.day,
  });

  final String indicatorName,
      criterionName,
      fileName,
      status,
      uploadedBy,
      quarter,
      month;
  final int year, day;
}
