import 'package:qualiverse/routing/all_routes_imports.dart';

class CriteriaResponseModel {
  final List<CriterionItemModel>? data;
  final bool? isSuccess;
  final ApiErrorModel? error;

  CriteriaResponseModel({
    required this.data,
    required this.isSuccess,
    required this.error,
  });

  factory CriteriaResponseModel.fromJson(Map<String, dynamic> json) {
    return CriteriaResponseModel(
      data: (json['data'] as List)
          .map((e) => CriterionItemModel.fromJson(e))
          .toList(),
      isSuccess: json['isSuccess'],
      error: json['error'] == null ? null : ApiErrorModel.fromJson(json['error']),
    );
  }
}

class CriterionItemModel {
  final int id;
  final String name;
  final String accreditation;
  final String department;
  final int indicatorsCount;
  final bool isEnabled;

  const CriterionItemModel({
    required this.id,
    required this.name,
    required this.accreditation,
    required this.department,
    required this.indicatorsCount,
    required this.isEnabled,
  });

  factory CriterionItemModel.fromJson(Map<String, dynamic> json) {
    return CriterionItemModel(
      id: json['id'],
      name: json['name'],
      accreditation: json['accreditation'] ?? '',
      department: json['department'] ?? '',
      indicatorsCount: json['indicatorsCount'] ?? 0,
      isEnabled: json['isEnabled'] ?? false,
    );
  }

  CriterionItemModel copyWith({
    int? id,
    String? name,
    String? accreditation,
    String? department,
    int? indicatorsCount,
    bool? isEnabled,
  }) {
    return CriterionItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      accreditation: accreditation ?? this.accreditation,
      department: department ?? this.department,
      indicatorsCount: indicatorsCount ?? this.indicatorsCount,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
