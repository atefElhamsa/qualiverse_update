import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';
import 'package:qualiverse/routing/app_routes.dart';

class AiReportBody extends StatefulWidget {
  final String? selectedProvider;
  final String? selectedCourseNature;
  final int courseId;

  const AiReportBody({
    super.key,
    this.selectedProvider,
    this.selectedCourseNature,
    required this.courseId,
  });

  @override
  State<AiReportBody> createState() => _AiReportBodyState();
}

class _AiReportBodyState extends State<AiReportBody> {
  // 0 = surveyPdf | 1 = descriptionPdf | 2 = statsPdf
  List<File?> _files = List<File?>.filled(3, null, growable: false);

  bool _isLoading = false;

  int get _uploadedCount => _files.where((f) => f != null).length;
  bool get _allUploaded => _uploadedCount == 3;
  double get _progress => _uploadedCount / 3;

  Future<void> _pickFile(int index) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() => _files[index] = File(result.files.single.path!));
    }
  }

  Future<void> _submit(BuildContext context) async {
    if (!_allUploaded) {
      final isAr = context.locale.languageCode == 'ar';
      showSnackBar(
        context,
        isAr
            ? 'يجب رفع الملفات الثلاثة أولاً'
            : 'Please upload all 3 files first',
        AppColors.red,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final data = await AiReportService.extractReport(
        provider: widget.selectedProvider,
        courseNature: widget.selectedCourseNature,
        courseId: widget.courseId,
        surveyPdf: _files[0]!,
        descriptionPdf: _files[1]!,
        statsPdf: _files[2]!,
      );
      if (mounted) {
        await context.pushNamed(AppRoutes.aiReportResultScreen, extra: data);
        if (mounted) {
          setState(() {
            _files.clear();
            _files = List<File?>.filled(3, null, growable: false);
          });
        }
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(
          context,
          e.toString().replaceFirst('Exception: ', ''),
          AppColors.red,
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<bool> _onWillPop(BuildContext context) async {
    if (_uploadedCount == 0) return true;

    final isAr = context.locale.languageCode == 'ar';

    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        icon: Icon(
          Icons.warning_amber_rounded,
          color: AppColors.red,
          size: 40.sp,
        ),
        title: Text(
          isAr ? 'تحذير' : 'Warning',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.red,
          ),
        ),
        content: Text(
          isAr
              ? 'لو رجعت هيتم مسح الملفات المرفوعة ($_uploadedCount/${_files.length}). هل أنت متأكد؟'
              : 'Going back will clear the uploaded files ($_uploadedCount/${_files.length}). Are you sure?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              isAr ? 'إلغاء' : 'Cancel',
              style: TextStyle(
                color: AppColors.colorButtonLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(isAr ? 'رجوع' : 'Go Back'),
          ),
        ],
      ),
    );

    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final isAr = context.locale.languageCode == 'ar';

    final fileItems = [
      FileItemModel(
        titleFile: 'surveyPDF',
        aboutFile: '',
        onTap: () => _pickFile(0),
        file: _files[0],
      ),
      FileItemModel(
        titleFile: 'descriptionPDF',
        aboutFile: '',
        onTap: () => _pickFile(1),
        file: _files[1],
      ),
      FileItemModel(
        titleFile: 'statisticsPDF',
        aboutFile: '',
        onTap: () => _pickFile(2),
        file: _files[2],
      ),
    ];

    return PopScope(
      canPop: _uploadedCount == 0,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldPop = await _onWillPop(context);
        if (shouldPop && context.mounted) {
          context.pop();
        }
      },
      child: Stack(
        children: [
          CustomScaffold(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AiReportTop(),
                const AiReportInfoBanner(),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45.w),
                  child: ListFileItemWidget(fileItemModels: fileItems),
                ),
                SizedBox(height: 20.h),
                AiReportBottomActionBar(
                  uploadedCount: _uploadedCount,
                  progress: _progress,
                  allUploaded: _allUploaded,
                  isAr: isAr,
                  onSubmit: () => _submit(context),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
          if (_isLoading) AiReportLoadingOverlay(isAr: isAr),
        ],
      ),
    );
  }
}
