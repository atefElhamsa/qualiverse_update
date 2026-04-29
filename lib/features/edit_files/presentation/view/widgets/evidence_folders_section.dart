import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:qualiverse/features/analysis_files/presentation/controller/evidence_folder_files_cubit.dart';

class EvidenceFoldersSection extends StatelessWidget {
  const EvidenceFoldersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvidenceFolderCubit, EvidenceFolderState>(
      builder: (context, state) {
        if (state is EvidenceFolderSuccess) {
          final folders = state.evidenceFolders;
          if (folders.isEmpty) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerWidget(
                widget: LayoutBuilder(
                  builder: (context, constraints) {
                    final itemWidth = (constraints.maxWidth - 10.w) / 2;
                    return Wrap(
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: folders.map((folder) {
                        return SizedBox(
                          width: itemWidth,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => BlocProvider(
                                  create: (_) =>
                                      EvidenceFolderFilesCubit()
                                        ..getEvidenceFiles(folderId: folder.id),
                                  child: Dialog(
                                    insetPadding: EdgeInsets.symmetric(
                                      horizontal: 40.w,
                                      vertical: 30.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.8,
                                      child: EvidenceFolderFilesScreen(
                                        folderName: folder.name,
                                        folderId: folder.id,
                                        isStatistics: true,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 12.h,
                                ),
                                constraints: BoxConstraints(minHeight: 56.h),
                                decoration: BoxDecoration(
                                  color: AppColors.grey,
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 38.w,
                                      height: 38.h,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            AppColors.itemContainerColorEdit1,
                                            AppColors.itemContainerColorEdit2,
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.folder_shared_rounded,
                                          color: AppColors.white,
                                          size: 24.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: Text(
                                        folder.name,
                                        style: GoogleFonts.cairo(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.mainBlack,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
