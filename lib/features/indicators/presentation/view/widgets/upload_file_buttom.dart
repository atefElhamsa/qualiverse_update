import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class UploadFileButtom extends StatefulWidget {
  const UploadFileButtom({
    super.key,
    required this.indicatorModel,
    required this.indicatorsArgs,
  });
  final IndicatorModel indicatorModel;
  final IndicatorsArgs indicatorsArgs;

  @override
  State<UploadFileButtom> createState() => _UploadFileButtomState();
}

class _UploadFileButtomState extends State<UploadFileButtom> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 51,
      child: ElevatedButton(
        onPressed: () {
          context.read<IndicatorsCubit>().pickAndUploadIndicatorFile(
            indicatorId: widget.indicatorModel.id,
            criterionId: widget.indicatorsArgs.accreditationModel.id,
          );
        },

        onHover: (isHovered) {
          setState(() {
            _isHovered = isHovered;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _isHovered
              ? Theme.of(context).scaffoldBackgroundColor == AppColors.white
                    ? AppColors.buttonUploadFileHoverd
                    : AppColors.white
              : AppColors.colorButtonLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          "uploadFile".tr(),
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
                ? AppColors.white
                : AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
