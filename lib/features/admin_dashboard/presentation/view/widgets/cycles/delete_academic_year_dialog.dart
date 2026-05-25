import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class DeleteAcademicYearDialog extends StatefulWidget {
  final AcademicYearModel academicYear;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const DeleteAcademicYearDialog({
    super.key,
    required this.academicYear,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  State<DeleteAcademicYearDialog> createState() =>
      _DeleteAcademicYearDialogState();
}

class _DeleteAcademicYearDialogState extends State<DeleteAcademicYearDialog> {
  final TextEditingController _controller = TextEditingController();
  bool _canConfirm = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final isMatch = _controller.text.trim().toLowerCase() == 'delete';
      if (isMatch != _canConfirm) {
        setState(() {
          _canConfirm = isMatch;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
                      title: 'deleteAcademicYear'.tr(),
                      textStyle: Theme.of(context).textTheme.titleLarge!
                          .copyWith(
                            fontSize: 15.sp,
                            color: AppColors.red,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onCancel,
                    icon: const Icon(Icons.close, size: 20),
                    color: const Color(0xFF6B6B80),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomText(
                title: 'deleteAcademicYearConfirm'.tr(
                  args: [widget.academicYear.yearNumber.toString()],
                ),
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.mainBlack,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
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
                    onPressed: widget.onCancel,
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
                    onPressed: _canConfirm ? widget.onConfirm : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.red,
                      disabledBackgroundColor: AppColors.grey.withOpacity(0.3),
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
                            color: _canConfirm
                                ? AppColors.white
                                : AppColors.grey,
                          ),
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

Future<void> onDeleteAcademicYear(
  BuildContext context,
  AcademicYearModel academicYear,
  AcademicYearCubit cubit,
) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => BlocProvider.value(
      value: cubit,
      child: DeleteAcademicYearDialog(
        academicYear: academicYear,
        onCancel: () => Navigator.of(ctx).pop(),
        onConfirm: () {
          cubit.deleteAcademicYear(id: academicYear.id);
          Navigator.of(ctx).pop();
        },
      ),
    ),
  );
}
