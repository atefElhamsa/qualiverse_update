class LevelResponseModel {
  final List<LevelModel> data;
  final bool isSuccess;

  LevelResponseModel({required this.data, required this.isSuccess});

  factory LevelResponseModel.fromJson(Map<String, dynamic> json) {
    return LevelResponseModel(
      data: (json['data'] as List).map((e) => LevelModel.fromJson(e)).toList(),
      isSuccess: json['isSuccess'] ?? false,
    );
  }
}

class LevelModel {
  final int id;
  final int levelNumber;
  final String name;

  LevelModel({required this.id, required this.levelNumber, required this.name});

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      id: json['id'] ?? 0,
      levelNumber: json['levelNumber'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
