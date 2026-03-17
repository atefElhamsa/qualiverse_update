import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class CreateFolderCubit extends Cubit<CreateFolderState> {
  CreateFolderCubit() : super(CreateFolderInitial());

  static CreateFolderCubit get(BuildContext context) =>
      BlocProvider.of<CreateFolderCubit>(context);

  final newFolderNameController = TextEditingController();

  Future<void> createFolder({required int courseId}) async {
    final folderName = newFolderNameController.text.trim();
    if (folderName.isEmpty) {
      emit(CreateFolderFailure(errorMessage: "fillAllFields".tr()));
      return;
    }
    try {
      emit(CreateFolderLoading());
      final result = await UpdateAndCreateFolderService.createFolder(
        courseId: courseId,
        name: folderName,
      );
      emit(CreateFolderSuccess(message: result));
      newFolderNameController.clear();
    } catch (e) {
      emit(
        CreateFolderFailure(
          errorMessage: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }
}
