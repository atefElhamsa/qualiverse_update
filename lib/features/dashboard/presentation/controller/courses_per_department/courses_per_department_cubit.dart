import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class CoursesPerDepartmentCubit extends Cubit<CoursesPerDepartmentState> {
  CoursesPerDepartmentCubit() : super(CoursesPerDepartmentInitial());

  static CoursesPerDepartmentCubit get(context) => BlocProvider.of(context);

  final List<DepartmentDataModel> data = [
    const DepartmentDataModel(label: 'Information System', value: 10),
    const DepartmentDataModel(label: 'Computer Science', value: 9),
    const DepartmentDataModel(label: 'Information Technology', value: 8),
    const DepartmentDataModel(label: 'Software Engineering', value: 7),
  ];

  void loadData() {
    emit(CoursesPerDepartmentLoaded(data: data));
  }
}
