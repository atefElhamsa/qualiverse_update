import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class FileItemWidget extends StatefulWidget {
  const FileItemWidget({super.key, required this.fileItemModel});

  // file item model
  final FileItemModel fileItemModel;

  @override
  State<FileItemWidget> createState() => _FileItemWidgetState();
}

class _FileItemWidgetState extends State<FileItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.fileItemModel.file == null
              ? widget.fileItemModel.onTap
              : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
            transformAlignment: Alignment.center,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 240.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF3B82F6,
                          ).withOpacity(_isHovered ? 0.15 : 0.08),
                          blurRadius: _isHovered ? 24 : 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.r),
                      child: DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          radius: Radius.circular(16.r),
                          strokeWidth: _isHovered ? 2.0 : 1.5,
                          color: const Color(
                            0xFF3B82F6,
                          ).withOpacity(_isHovered ? 0.6 : 0.3),
                          dashPattern: const [8, 6],
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: widget.fileItemModel.file == null
                                  ? AiReportNotFoundFile(
                                      titleFile: widget.fileItemModel.titleFile,
                                    )
                                  : AiReportFoundFile(
                                      file: widget.fileItemModel.file,
                                    ),
                            ),
                            if (widget.fileItemModel.file != null)
                              Positioned(
                                top: 10.h,
                                right: 10.w,
                                child: Tooltip(
                                  message: "changeFile".tr(),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20.r),
                                      onTap: widget.fileItemModel.onTap,
                                      child: Container(
                                        padding: EdgeInsets.all(8.r),
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.colorTapAdminDashboard,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.05,
                                              ),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.edit,
                                          color: AppColors.colorButtonLight,
                                          size: 20.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
