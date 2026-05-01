import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as SemesterCubit;
import 'package:qualiverse/core/shared_widgets/custom_base_drop_down.dart';
import '../../../../../../../../../routing/all_routes_imports.dart';

class SemesterDropDownWidget extends StatefulWidget {
  final double? height;
  final bool isExpanded;
  final ValueChanged<int>? onChanged;
  final int? selectedId;
  final bool useCubitSelection;

  const SemesterDropDownWidget({
    super.key,
    this.height,
    this.isExpanded = true,
    this.onChanged,
    this.selectedId,
    this.useCubitSelection = true,
  });

  @override
  State<SemesterDropDownWidget> createState() => _SemesterDropDownWidgetState();
}

class _SemesterDropDownWidgetState extends State<SemesterDropDownWidget> {
  @override
  void initState() {
    super.initState();
    TermCubit.get(context).fetchTerms();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TermCubit, TermState>(
      builder: (context, state) {
        if (state is TermLoading) {
          return const CustomLoading();
        }
        if (state is TermError) {
          return RetryWidget(
            title: state.message,
            onPressed: () => TermCubit.get(context).fetchTerms(),
          );
        }
        if (state is TermSuccess) {
          final semesters = state.terms;
          final isValid = semesters.any(
            (e) => e.id == state.selectedTerm?.id,
          );
          final selectedValue =
              widget.selectedId ??
              (widget.useCubitSelection && isValid
                  ? state.selectedTerm?.id
                  : null);
          final selectedItem = semesters
              .where((s) => s.id == selectedValue)
              .firstOrNull;

          return CustomBaseDropDown<TermModel>(
            items: semesters,
            itemLabelBuilder: (s) => s.name,
            itemValueBuilder: (s) => s.id,
            value: selectedItem,
            hint: 'term'.tr(),
            height: widget.height,
            isExpanded: widget.isExpanded,
            onChanged: (value) {
              if (value == null) return;
              if (widget.onChanged != null) {
                widget.onChanged!(value as int);
                return;
              }
              final selectedModel = semesters.firstWhere((s) => s.id == value);
              TermCubit.get(
                context,
              ).selectTerm(term: selectedModel);
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
