import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_dialog.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/view/widgets/cycles/cycles_details/criterions/widgets/create_criterion_dialog_widgets.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/cycles/indicators/cycle_indicator_cubit.dart';
import 'package:easy_localization/easy_localization.dart';

void showAddIndicatorDialog(BuildContext context, CriterionItemModel criterion) {
  showDialog(
    context: context,
    builder: (context) => AddIndicatorDialog(criterion: criterion),
  );
}

class AddIndicatorDialog extends StatefulWidget {
  final CriterionItemModel criterion;
  const AddIndicatorDialog({super.key, required this.criterion});

  @override
  State<AddIndicatorDialog> createState() => _AddIndicatorDialogState();
}

class _AddIndicatorDialogState extends State<AddIndicatorDialog> {
  final TextEditingController nameArController = TextEditingController();
  final TextEditingController descArController = TextEditingController();
  final TextEditingController nameEnController = TextEditingController();
  final TextEditingController descEnController = TextEditingController();

  @override
  void dispose() {
    nameArController.dispose();
    descArController.dispose();
    nameEnController.dispose();
    descEnController.dispose();
    super.dispose();
  }

  void handleAddIndicator() {
    if (nameArController.text.isEmpty ||
        descArController.text.isEmpty ||
        nameEnController.text.isEmpty ||
        descEnController.text.isEmpty) {
      showSnackBar(context, 'pleaseFillAllFields'.tr(), AppColors.red);
      return;
    }

    context.read<CycleIndicatorCubit>().createNewIndicator(
          criterionId: widget.criterion.id,
          nameAr: nameArController.text,
          descriptionAr: descArController.text,
          nameEn: nameEnController.text,
          descriptionEn: descEnController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final academicYear =
        AcademicYearCubit.get(context).selectedAcademicYear?.yearNumber.toString() ??
        '2025';

    return CustomDialog(
      title: 'addIndicator'.tr(),
      maxWidth: 700.w,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReadonlyInfo('academicYear'.tr(), academicYear),
            _buildReadonlyInfo('accreditationType'.tr(), widget.criterion.accreditation),
            _buildReadonlyInfo('department'.tr(), widget.criterion.department.isEmpty ? '--' : widget.criterion.department),
            _buildReadonlyInfo('criterionName'.tr(), widget.criterion.name),
            Divider(height: 32.h, color: AppColors.grey.withOpacity(0.2)),
            
            Row(
              children: [
                Expanded(
                  child: buildFormField(
                    label: 'indicatorNameArabic'.tr(),
                    hint: 'indicatorNameArabicHint'.tr(),
                    controller: nameArController,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: buildFormField(
                    label: 'indicatorNameEnglish'.tr(),
                    hint: 'indicatorNameEnglishHint'.tr(),
                    controller: nameEnController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: buildFormField(
                    label: 'descriptionArabic'.tr(),
                    hint: 'descriptionArabicHint'.tr(),
                    controller: descArController,
                    maxLines: 3,
                    height: 100.h,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: buildFormField(
                    label: 'descriptionEnglish'.tr(),
                    hint: 'descriptionEnglishHint'.tr(),
                    controller: descEnController,
                    maxLines: 3,
                    height: 100.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        buildActionButton(
          title: 'cancel'.tr(),
          onPressed: () => Navigator.pop(context),
          backgroundColor: const Color(0xFFE5E7EB),
          textColor: AppColors.mainBlack,
        ),
        BlocListener<CycleIndicatorCubit, CycleIndicatorState>(
          listener: (context, state) {
            if (state is CycleIndicatorCreateSuccess) {
              showSnackBar(context, state.message, AppColors.green);
              Navigator.pop(context);
              // Optionally refresh indicators list if we are in a view that shows them
            } else if (state is CycleIndicatorActionError) {
              showSnackBar(context, state.error, AppColors.red);
            }
          },
          child: buildActionButton(
            title: 'addIndicator'.tr(),
            onPressed: handleAddIndicator,
            backgroundColor: const Color(0xFF2C3E8A),
            textColor: AppColors.white,
            isBold: true,
          ),
        ),
      ],
    );
  }

  Widget _buildReadonlyInfo(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          SizedBox(
            width: 150.w,
            child: CustomText(
              title: label,
              textStyle: TextStyle(
                fontSize: 15.sp,
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: CustomText(
              title: value,
              textStyle: TextStyle(
                fontSize: 15.sp,
                color: AppColors.mainBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
