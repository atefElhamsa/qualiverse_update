class CourseItemModel {
  final int courseId;
  final String name;
  final String code;
  final String department;
  final String level;
  final String semester;
  final String doctor;

  const CourseItemModel({
    required this.courseId,
    required this.name,
    required this.code,
    required this.department,
    required this.level,
    required this.semester,
    required this.doctor,
  });

  bool get isAssigned => doctor != '-';
}
