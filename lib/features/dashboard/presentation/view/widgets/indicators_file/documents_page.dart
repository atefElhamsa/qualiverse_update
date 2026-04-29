import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/documents/documents_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/documents/documents_state.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'documents_header_row.dart';
import 'animated_doc_row.dart';
import 'package:easy_localization/easy_localization.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentsCubit, DocumentsState>(
      builder: (context, state) {
        if (state is DocumentsLoaded) {
          if (state.docs.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: CustomText(
                  title: 'noIndicatorsFound'.tr(),
                  textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.textGrey.withOpacity(0.5),
                  ),
                ),
              ),
            );
          }
          return Column(
            children: [
              const DocumentsHeaderRow(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: state.docs.length,
                itemBuilder: (_, i) => AnimatedDocRow(
                  key: ValueKey(i),
                  doc: state.docs[i],
                  index: i,
                ),
              ),
            ],
          );
        }
        return const CustomLoading();
      },
    );
  }
}
