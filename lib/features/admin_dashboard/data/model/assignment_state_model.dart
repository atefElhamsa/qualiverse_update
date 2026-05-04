class AssignmentStatusResponseModel {
  final List<AssignmentStateModel> data;
  AssignmentStatusResponseModel({required this.data});
  factory AssignmentStatusResponseModel.fromJson(List<dynamic> json) {
    return AssignmentStatusResponseModel(
      data: json.map((x) => AssignmentStateModel.fromJson(x)).toList(),
    );
  }
}

class AssignmentStateModel {
  final int value;
  final String name;
  AssignmentStateModel({required this.name, required this.value});

  factory AssignmentStateModel.fromJson(Map<String, dynamic> json) {
    return AssignmentStateModel(name: json['name'], value: json['value']);
  }
}
