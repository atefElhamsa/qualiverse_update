import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class DeleteFolderCubit extends Cubit<DeleteFolderState> {
  DeleteFolderCubit() : super(DeleteFolderInitial());

  static DeleteFolderCubit get(BuildContext context) =>
      BlocProvider.of<DeleteFolderCubit>(context);

  Future<void> deleteFolder({required int folderId}) async {
    try {
      emit(DeleteFolderLoading());
      final result = await UpdateAndCreateAndDeleteFolderService.deleteFolder(
        folderId: folderId,
      );
      emit(DeleteFolderSuccess(message: result));
    } catch (e) {
      emit(
        DeleteFolderFailure(
          errorMessage: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }
}
