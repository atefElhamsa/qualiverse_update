import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class BuildBodyFileGeneral extends StatelessWidget {
  const BuildBodyFileGeneral({
    super.key,
    required this.cubit,
    required this.folderId,
    required this.academicYearId,
    required this.termId,
    required this.levelId,
    required this.courseId,
    required this.departmentId,
  });
  final EvidenceFolderFilesCubit cubit;
  final int folderId;
  final int academicYearId;
  final int termId;
  final int levelId;
  final int courseId;
  final int? departmentId;

  @override
  Widget build(BuildContext context) {
    final state = cubit.state;
    if (state is EvidenceFolderFilesLoading && cubit.allFiles.isEmpty) {
      return const CustomLoading();
    }
    if (state is EvidenceFolderFilesFailure && cubit.allFiles.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(40.w),
          child: RetryWidget(
            title: state.error,
            onPressed: () => cubit.getGeneralFiles(
              id: folderId,
              academicYearId: academicYearId,
              termId: termId,
              levelId: levelId,
              courseId: courseId,
              departmentId: departmentId,
            ),
          ),
        ),
      );
    }
    final list = cubit.filteredFiles;
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open_rounded,
              size: 64.sp,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 12.h),
            Text(
              "noDataFound".tr(),
              style: GoogleFonts.almarai(fontSize: 13.sp, color: Colors.grey),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
      itemCount: list.length,
      separatorBuilder: (_, _) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        return EvidenceFolderFileItem(
          file: list[index],
          isArabic: context.locale.languageCode == 'ar',
          folderId: folderId,
        );
      },
    );
  }
}
