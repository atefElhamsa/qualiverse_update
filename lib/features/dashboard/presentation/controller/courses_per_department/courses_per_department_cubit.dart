import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class CoursesPerDepartmentCubit extends Cubit<CoursesPerDepartmentState> {
  final List<DepartmentDataModel> data;

  CoursesPerDepartmentCubit({required this.data}) : super(CoursesPerDepartmentInitial());

  static CoursesPerDepartmentCubit get(context) => BlocProvider.of(context);

  void loadData() {
    emit(CoursesPerDepartmentLoaded(data: data));
  }
}
