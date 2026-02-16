import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class SelectedLevelWidget extends StatelessWidget {
  const SelectedLevelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelCubit, LevelState>(
      builder: (context, state) {
        if (state is LevelLoading) {
          return const CustomLoading();
        }
        if (state is LevelError) {
          return RetryWidget(
            title: state.message,
            onPressed: () {
              LevelCubit.get(context).fetchLevels();
            },
          );
        }
        if (state is LevelSuccess) {
          final levelCubit = LevelCubit.get(context);
          final List<String> levelNames = state.levels
              .map((e) => e.name)
              .toList();
          final String? selectedLevelName = state.selectedLevel?.name;
          return CustomDropButtonAndTitle(
            dropButtonModel: DropButtonModel(
              selectedData: selectedLevelName,
              listOfData: levelNames,
              hintText: "chooseStudyLevel".tr(),
              hintSize: 20.sp,
              onChanged: (value) {
                if (value == null) return;
                final selectedModel = state.levels.firstWhere(
                  (d) => d.name == value,
                );
                levelCubit.selectLevel(level: selectedModel);
              },
            ),
            title: "level".tr(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
