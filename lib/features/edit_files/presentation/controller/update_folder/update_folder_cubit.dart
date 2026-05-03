import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class UpdateFolderCubit extends Cubit<UpdateFolderState> {
  UpdateFolderCubit() : super(UpdateFolderInitial());

  static UpdateFolderCubit get(BuildContext context) =>
      BlocProvider.of<UpdateFolderCubit>(context);

  final editFolderNameArController = TextEditingController();
  final editFolderNameEnController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> updateFolder({required int folderId}) async {
    final folderNameAr = editFolderNameArController.text.trim();
    final folderNameEn = editFolderNameEnController.text.trim();

    final nameArError = MyValidators.arabicValidator(folderNameAr);
    final nameEnError = MyValidators.englishValidator(folderNameEn);

    if (nameArError != null || nameEnError != null) {
      formKey.currentState!.validate();
      emit(UpdateFolderFailure(errorMessage: nameArError ?? nameEnError!));
      return;
    }

    try {
      emit(UpdateFolderLoading());
      final result = await UpdateAndCreateAndDeleteFolderService.updateFolder(
        folderId: folderId,
        nameAr: folderNameAr,
        nameEn: folderNameEn,
      );
      editFolderNameArController.clear();
      editFolderNameEnController.clear();
      emit(UpdateFolderSuccess(message: result));
    } catch (e) {
      emit(
        UpdateFolderFailure(
          errorMessage: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }
}
