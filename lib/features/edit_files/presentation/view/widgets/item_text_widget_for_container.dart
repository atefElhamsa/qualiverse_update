import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../routing/all_routes_imports.dart';

class ItemTextWidgetForContainer extends StatefulWidget {
  const ItemTextWidgetForContainer({
    super.key,
    required this.courseFolderModel,
  });

  final CourseFolderModel courseFolderModel;

  @override
  State<ItemTextWidgetForContainer> createState() => _ItemTextWidgetForContainerState();
}

class _ItemTextWidgetForContainerState extends State<ItemTextWidgetForContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final folderName = widget.courseFolderModel.name;
    return Tooltip(
      message: folderName,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          constraints: BoxConstraints(minHeight: 56.h),
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0xFFF1F5F9) : AppColors.grey,
            borderRadius: BorderRadius.circular(25.r),
            boxShadow: _isHovered 
                ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]
                : [],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 38.w,
                height: 38.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _isHovered 
                        ? [const Color(0xFF0F569E), const Color(0xFF4285F4)]
                        : [AppColors.itemContainerColorEdit1, AppColors.itemContainerColorEdit2],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: _isHovered
                      ? [BoxShadow(color: const Color(0xFF4285F4).withOpacity(0.3), blurRadius: 5, offset: const Offset(0, 2))]
                      : [],
                ),
                child: Center(
                  child: Icon(
                    Icons.folder_open_rounded,
                    color: AppColors.white,
                    size: 24.sp,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  folderName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.almarai(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: _isHovered ? const Color(0xFF0F569E) : AppColors.mainBlack,
                  ),
                ),
              ),
              if (folderName != 'Report' &&
                  folderName != 'Description' &&
                  folderName != 'التقرير' &&
                  folderName != 'توصيف المقرر')
                EditDeleteDownloadList(
                  onTap: () {
                    CourseFolderCubit.get(
                      context,
                    ).selectCourseFolder(courseFolder: widget.courseFolderModel);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
