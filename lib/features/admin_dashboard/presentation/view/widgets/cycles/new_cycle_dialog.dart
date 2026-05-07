import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class NewCycleDialog extends StatelessWidget {
  final TextEditingController yearController;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const NewCycleDialog({
    super.key,
    required this.yearController,
    required this.onCancel,
    required this.onConfirm,
  });

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
                      title: 'createNewCycle'.tr(),
                      textStyle: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(fontSize: 15.sp),
                    ),
                  ),
                  IconButton(
                    onPressed: onCancel,
                    icon: const Icon(Icons.close, size: 20),
                    color: const Color(0xFF6B6B80),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              CustomText(
                title: 'yearLabel'.tr(),
                textStyle: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontSize: 15.sp),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: yearController,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.blue,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              CustomText(
                title: 'newCycleHelper'.tr(),
                textStyle: const TextStyle(fontSize: 12, color: Color(0xFF9999AA)),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: onCancel,
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
                  FilledButton(
                    onPressed: onConfirm,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: CustomText(
                      title: 'createCycle'.tr(),
                      textStyle: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(color: AppColors.white),
                    ),
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

Future<void> onNewCycle(BuildContext context, AcademicYearCubit cubit) async {
  final yearController = TextEditingController(
    text: (DateTime.now().year + 1).toString(),
  );

  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => BlocProvider.value(
      value: cubit,
      child: NewCycleDialog(
        yearController: yearController,
        onCancel: () => Navigator.of(ctx).pop(),
        onConfirm: () {
          final year = int.tryParse(yearController.text.trim());
          if (year != null) {
            cubit.addAcademicYear(yearNumber: year);
            Navigator.of(ctx).pop();
          }
        },
      ),
    ),
  );

  yearController.dispose();
}
