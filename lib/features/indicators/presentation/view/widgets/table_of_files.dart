import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class TableOfFiles extends StatelessWidget {
  const TableOfFiles({
    super.key,
    required this.indicatorsArgs,
    required this.indicators,
  });

  final IndicatorsArgs indicatorsArgs;
  final List<IndicatorModel> indicators;

  @override
  Widget build(BuildContext context) {
    return indicators.isEmpty
        ? EmptyIndicatorsList()
        : BlocListener<IndicatorsCubit, IndicatorsState>(
            listener: (context, state) {
              if (state is IndicatorUploadLoading) {
                showSnackBar(
                  context,
                  "please_wait_uploading".tr(),
                  AppColors.green,
                );
              }
              if (state is IndicatorsError) {
                showSnackBar(context, state.message, Colors.red);
              }
            },
            child: NoEmptyIndicatorsList(
              indicators: indicators,
              indicatorsArgs: indicatorsArgs,
            ),
          );
  }
}
