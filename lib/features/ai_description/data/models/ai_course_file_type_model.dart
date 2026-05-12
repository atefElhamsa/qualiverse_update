class AiCourseFileTypeModel {
  final int value;
  final String name;

  AiCourseFileTypeModel({required this.value, required this.name});

  factory AiCourseFileTypeModel.fromJson(Map<String, dynamic> json) {
    return AiCourseFileTypeModel(
      value: json['value'],
      name: json['name'],
    );
  }
}
