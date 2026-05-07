import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'add_indicator_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

class CriterionsRowWidget extends StatefulWidget {
  final CriterionItemModel criterion;
  final int index;
  final int total;

  const CriterionsRowWidget({
    super.key,
    required this.criterion,
    required this.index,
    required this.total,
  });

  @override
  State<CriterionsRowWidget> createState() => _CriterionsRowWidgetState();
}

class _CriterionsRowWidgetState extends State<CriterionsRowWidget> {
  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _isEnabled = widget.criterion.isEnabled;
  }

  @override
  void didUpdateWidget(covariant CriterionsRowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.criterion.isEnabled != widget.criterion.isEnabled) {
      setState(() {
        _isEnabled = widget.criterion.isEnabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        hoverColor: const Color(0xFFF9FAFB),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
              bottom: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
              left: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
              right: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
            ),
          ),
          child: _buildRow(context),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Criterion Name
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE6E5F5),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: CustomText(
                title: widget.criterion.name,
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 13.sp,
                  color: const Color(0xFF4B4A6A),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // Accreditation
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: (widget.criterion.accreditation == 'Program' ||
                          widget.criterion.accreditation == 'program'.tr())
                      ? const Color(0xFFD6E4F0)
                      : const Color(0xFFEAD6F0),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: CustomText(
                  title: widget.criterion.accreditation,
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 13.sp,
                    color: (widget.criterion.accreditation == 'Program' ||
                            widget.criterion.accreditation == 'program'.tr())
                        ? const Color(0xFF2C5C8A)
                        : const Color(0xFF8A2C8A),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // Department
          Expanded(
            child: Center(
              child: CustomText(
                title: widget.criterion.department.isEmpty
                    ? '--'
                    : widget.criterion.department,
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 13.sp,
                  color: AppColors.mainBlack,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // Indicators Count
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  title: widget.criterion.indicatorsCount.toString(),
                  textStyle: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(fontSize: 13.sp),
                ),
                SizedBox(width: 12.w),
                MouseRegion(
                  cursor: _isEnabled
                      ? SystemMouseCursors.click
                      : SystemMouseCursors.basic,
                  child: GestureDetector(
                    onTap: _isEnabled
                        ? () => showAddIndicatorDialog(context, widget.criterion)
                        : null,
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: _isEnabled
                            ? const Color(0xFFD3DCE6)
                            : const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 13.sp,
                        color: _isEnabled
                            ? AppColors.mainBlack
                            : AppColors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          // Status
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _isEnabled
                      ? const Color(0xFF3B7D50)
                      : const Color(0xFFBE1E2D),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: CustomText(
                  title: _isEnabled ? 'enabled'.tr() : 'disabled'.tr(),
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // Actions
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    height: 24.h,
                    width: 40.w,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: CupertinoSwitch(
                        value: _isEnabled,
                        activeTrackColor: const Color(0xFF3B7D50),
                        inactiveTrackColor: const Color(0xFFBE1E2D),
                        onChanged: (val) {
                          context.read<CriterionsCubit>().toggleCriterionStatus(
                            criterionId: widget.criterion.id,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
