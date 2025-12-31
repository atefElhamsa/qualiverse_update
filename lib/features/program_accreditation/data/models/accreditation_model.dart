class AccreditationModel {
  final int id;
  final String name;

  AccreditationModel({required this.id, required this.name});

  factory AccreditationModel.fromJson(Map<String, dynamic> json) {
    return AccreditationModel(id: json['id'], name: json['name']);
  }
}
