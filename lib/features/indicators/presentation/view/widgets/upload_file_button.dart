import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class UploadFileButton extends StatelessWidget {
  const UploadFileButton({
    super.key,
    required this.indicatorModel,
    required this.indicatorsArgs,
  });

  final IndicatorModel indicatorModel;
  final IndicatorsArgs indicatorsArgs;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndicatorsCubit, IndicatorsState>(
      builder: (context, state) {
        final isLoading =
            state is IndicatorUploadLoading &&
            state.indicatorId == indicatorModel.id;
        return SizedBox(
          width: 128,
          height: 51,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    context.read<IndicatorsCubit>().pickAndUploadIndicatorFile(
                      indicatorId: indicatorModel.id,
                      criterionId: indicatorsArgs.accreditationModel.id,
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorButtonLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    "uploadFile".tr(),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
