import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class UpdateFolderCubit extends Cubit<UpdateFolderState> {
  UpdateFolderCubit() : super(UpdateFolderInitial());

  static UpdateFolderCubit get(BuildContext context) =>
      BlocProvider.of<UpdateFolderCubit>(context);

  final editFolderNameController = TextEditingController();

  Future<void> updateFolder({required int folderId}) async {
    final folderName = editFolderNameController.text.trim();
    if (folderName.isEmpty) {
      emit(UpdateFolderFailure(errorMessage: "fillAllFields".tr()));
      return;
    }
    try {
      emit(UpdateFolderLoading());
      final result = await UpdateAndCreateFolderService.updateFolder(
        folderId: folderId,
        name: folderName,
      );
      emit(UpdateFolderSuccess(message: result));
      editFolderNameController.clear();
    } catch (e) {
      emit(
        UpdateFolderFailure(
          errorMessage: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }
}
