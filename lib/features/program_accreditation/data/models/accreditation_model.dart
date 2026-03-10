class AccreditationsResponseModel {
  final List<AccreditationModel> data;
  final bool isSuccess;

  AccreditationsResponseModel({required this.data, required this.isSuccess});

  factory AccreditationsResponseModel.fromJson(Map<String, dynamic> json) {
    return AccreditationsResponseModel(
      data: (json['data'] as List)
          .map((e) => AccreditationModel.fromJson(e))
          .toList(),
      isSuccess: json['isSuccess'] ?? false,
    );
  }
}

class AccreditationModel {
  final int id;
  final String name;

  AccreditationModel({required this.id, required this.name});

  factory AccreditationModel.fromJson(Map<String, dynamic> json) {
    return AccreditationModel(id: json['id'], name: json['name']);
  }
}
