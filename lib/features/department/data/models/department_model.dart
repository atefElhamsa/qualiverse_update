class DepartmentsResponseModel {
  final List<DepartmentModel> data;
  final bool isSuccess;

  DepartmentsResponseModel({required this.data, required this.isSuccess});

  factory DepartmentsResponseModel.fromJson(Map<String, dynamic> json) {
    return DepartmentsResponseModel(
      data: (json['data'] as List)
          .map((e) => DepartmentModel.fromJson(e))
          .toList(),
      isSuccess: json['isSuccess'] ?? false,
    );
  }
}

class DepartmentModel {
  final int id;
  final String code;
  final String name;

  DepartmentModel({required this.id, required this.code, required this.name});

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
    );
  }
}
