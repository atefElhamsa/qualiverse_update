import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class CreateFolderCubit extends Cubit<CreateFolderState> {
  CreateFolderCubit() : super(CreateFolderInitial());

  static CreateFolderCubit get(BuildContext context) =>
      BlocProvider.of<CreateFolderCubit>(context);

  final newFolderNameArController = TextEditingController();
  final newFolderNameEnController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> createFolder({required int courseId}) async {
    final folderNameAr = newFolderNameArController.text.trim();
    final folderNameEn = newFolderNameEnController.text.trim();
    if (folderNameAr.isEmpty || folderNameEn.isEmpty) {
      emit(CreateFolderFailure(errorMessage: "fillAllFields".tr()));
      return;
    }
    try {
      emit(CreateFolderLoading());
      final result = await UpdateAndCreateAndDeleteFolderService.createFolder(
        courseId: courseId,
        nameAr: folderNameAr,
        nameEn: folderNameEn,
      );
      newFolderNameArController.clear();
      newFolderNameEnController.clear();
      emit(CreateFolderSuccess(message: result));
    } catch (e) {
      emit(
        CreateFolderFailure(
          errorMessage: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }
}
