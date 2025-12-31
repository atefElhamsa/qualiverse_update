class TypeModel {
  final int id;
  final String type;

  TypeModel({required this.id, required this.type});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(id: json['id'], type: json['type']);
  }
}
