import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../routing/all_routes_imports.dart';

class EditDeleteDownloadList extends StatelessWidget {
  const EditDeleteDownloadList({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateFolderCubit, UpdateFolderState>(
      listener: (context, state) {
        if (state is UpdateFolderFailure) {
          showSnackBar(context, state.errorMessage, AppColors.red);
        }
      },
      builder: (context, state) {
        final updateFolderCubit = UpdateFolderCubit.get(context);
        return BlocBuilder<DeleteFolderCubit, DeleteFolderState>(
          builder: (context, state) {
            final deleteFolderCubit = DeleteFolderCubit.get(context);
            return PopMenuSuccessEditDeleteDownloadWidget(
              onTap: onTap,
              updateFolderCubit: updateFolderCubit,
              deleteFolderCubit: deleteFolderCubit,
            );
          },
        );
      },
    );
  }
}

PopupMenuItem<String> buildMenuItem({
  required String value,
  required IconData icon,
  required String text,
}) {
  return PopupMenuItem<String>(
    value: value,
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 10.w),
        CustomText(
          title: text.tr(),
          textStyle: GoogleFonts.cairo(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
