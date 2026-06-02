import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/dropdown_shimmer.dart';
import '../../../../../routing/all_routes_imports.dart';

class SelectedSemesterWidget extends StatelessWidget {
  const SelectedSemesterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TermCubit, TermState>(
      builder: (context, state) {
        if (state is TermLoading) {
          return const DropdownShimmer();
        }
        if (state is TermError) {
          return RetryWidget(
            title: state.message,
            onPressed: () {
              TermCubit.get(context).fetchTerms();
            },
          );
        }
        if (state is TermSuccess) {
          final termCubit = TermCubit.get(context);
          final List<String> termNames = state.terms
              .map((e) => e.name)
              .toList();
          final String? selectedTermName = state.selectedTerm?.name;
          return CustomDropButtonAndTitle(
            dropButtonModel: DropButtonModel(
              selectedData: selectedTermName,
              listOfData: termNames,
              hintText: "chooseTerm".tr(),
              hintSize: 20.sp,
              onChanged: (value) {
                if (value == null) return;
                final selectedModel = state.terms.firstWhere(
                  (d) => d.name == value,
                );
                termCubit.selectTerm(term: selectedModel);
              },
            ),
            title: "term".tr(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
