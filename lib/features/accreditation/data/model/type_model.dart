class AccreditationType {
  final bool isSuccess;
  final List<TypeModel> types;

  AccreditationType({required this.isSuccess, required this.types});

  factory AccreditationType.fromJson(Map<String, dynamic> json) {
    return AccreditationType(
      types: (json['data'] as List).map((e) => TypeModel.fromJson(e)).toList(),
      isSuccess: json['isSuccess'],
    );
  }
}

class TypeModel {
  final int id;
  final String name;

  TypeModel({required this.id, required this.name});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(id: json['id'], name: json['name']);
  }
}
