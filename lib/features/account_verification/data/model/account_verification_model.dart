class AccountVerificationModel {
  final String type;
  final String title;
  final int status;
  final List<String> errors;

  const AccountVerificationModel({
    required this.type,
    required this.title,
    required this.status,
    required this.errors,
  });

  factory AccountVerificationModel.fromJson(Map<String, dynamic> json) {
    return AccountVerificationModel(
      type: json['type'] as String? ?? '',
      title: json['title'] as String? ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
      errors:
          (json['errors'] as List?)?.map((e) => e.toString()).toList() ??
          const [],
    );
  }
}
