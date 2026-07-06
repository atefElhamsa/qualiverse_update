import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

void showDeleteIndicatorDialog({
  required BuildContext context,
  required CycleIndicatorModel cycleIndicator,
}) {
  final cubit = context.read<CycleIndicatorCubit>();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: cubit,
        child: BlocListener<CycleIndicatorCubit, CycleIndicatorState>(
          listener: (ctx, state) {
            if (state is CycleIndicatorActionError) {
              showSnackBar(ctx, state.error, AppColors.red);
            }

            if (state is CycleIndicatorDeleteSuccess) {
              // Capture IDs before context becomes invalid
              final yearId = AcademicYearCubit.get(
                ctx,
              ).selectedAcademicYear?.id;
              final deptId = DepartmentCubit.get(ctx).selectedDepartment?.id;
              final criterionId = ProgramAccreditationCubit.get(
                ctx,
              ).selectedProgramAccreditation?.id;

              Navigator.of(dialogContext).pop();

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (ctx.mounted) {
                  showSnackBar(ctx, state.msg, AppColors.green);
                }

                // Use captured IDs to re-fetch data
                if (yearId != null && criterionId != null) {
                  cubit.fetchCycleIndicators(
                    yearId: yearId,
                    departmentId: deptId,
                    criterionId: criterionId,
                  );
                }
              });
            }
          },
          child: DeleteIndicatorDialog(
            cycleIndicator: cycleIndicator,
            cubit: cubit,
          ),
        ),
      );
    },
  );
}

class DeleteIndicatorDialog extends StatefulWidget {
  final CycleIndicatorModel cycleIndicator;
  final CycleIndicatorCubit cubit;

  const DeleteIndicatorDialog({
    super.key,
    required this.cycleIndicator,
    required this.cubit,
  });

  @override
  State<DeleteIndicatorDialog> createState() => _DeleteIndicatorDialogState();
}

class _DeleteIndicatorDialogState extends State<DeleteIndicatorDialog> {
  final TextEditingController _deleteController = TextEditingController();
  bool _canDelete = false;

  @override
  void initState() {
    super.initState();
    _deleteController.addListener(() {
      setState(() {
        _canDelete = _deleteController.text.toLowerCase() == 'delete';
      });
    });
  }

  @override
  void dispose() {
    _deleteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomText(
                      title: 'deleteIndicator'.tr(),
                      textStyle: Theme.of(context).textTheme.titleLarge!
                          .copyWith(
                            fontSize: 15.sp,
                            color: AppColors.red,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, size: 20),
                    color: const Color(0xFF6B6B80),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomText(
                title:
                    "${"deleteFileMessage".tr()} \"${widget.cycleIndicator.indicatorName}\"?",
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.mainBlack,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _deleteController,
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.red,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              CustomText(
                title: 'typeDeleteToConfirm'.tr(),
                textStyle: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9999AA),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF2C2C3E),
                      side: const BorderSide(color: Color(0xFFBBBBCC)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: CustomText(
                      title: 'cancel'.tr(),
                      textStyle: Theme.of(context).textTheme.titleMedium!,
                    ),
                  ),
                  const SizedBox(width: 12),
                  BlocBuilder<CycleIndicatorCubit, CycleIndicatorState>(
                    builder: (context, state) {
                      if (state is CycleIndicatorActionLoading) {
                        return const SizedBox(
                          height: 36,
                          width: 36,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      }
                      return FilledButton(
                        onPressed: _canDelete
                            ? () {
                                widget.cubit.deleteCycleIndicator(
                                  indicatorId: widget.cycleIndicator.id,
                                );
                              }
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.red,
                          disabledBackgroundColor: AppColors.grey.withOpacity(
                            0.3,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: CustomText(
                          title: 'delete'.tr(),
                          textStyle: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                color: _canDelete
                                    ? AppColors.white
                                    : AppColors.grey,
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
