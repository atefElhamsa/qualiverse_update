class EvidenceFolderModel {
  final int id;
  final String name;
  final String description;

  EvidenceFolderModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory EvidenceFolderModel.fromJson(Map<String, dynamic> json) {
    return EvidenceFolderModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
