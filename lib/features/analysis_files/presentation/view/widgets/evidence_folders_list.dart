import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceFoldersList extends StatelessWidget {
  const EvidenceFoldersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvidenceFolderCubit, EvidenceFolderState>(
      builder: (context, state) {
        if (state is EvidenceFolderLoading) {
          return const CustomLoading();
        }
        if (state is EvidenceFolderError) {
          return RetryWidget(
            title: state.message,
            onPressed: () =>
                context.read<EvidenceFolderCubit>().fetchEvidenceFolders(),
          );
        }
        if (state is EvidenceFolderSuccess) {
          final evidenceFolders = state.evidenceFolders;
          if (evidenceFolders.isEmpty) {
            return RetryWidget(
              title: 'noDataFound1'.tr(),
              onPressed: () =>
                  context.read<EvidenceFolderCubit>().fetchEvidenceFolders(),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section header
                Row(
                  children: [
                    Container(
                      width: 4.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: AppColors.progressColor,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'evidenceFolders'.tr(),
                      style: GoogleFonts.cairo(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.progressColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        '${evidenceFolders.length}',
                        style: GoogleFonts.cairo(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.progressColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Folders list
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: evidenceFolders.length,
                  separatorBuilder: (_, _) => SizedBox(height: 12.h),
                  itemBuilder: (_, index) => ItemEvidenceFolderWidget(
                    itemFolderModel: items[index % items.length],
                    evidenceFolderModel: evidenceFolders[index],
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
