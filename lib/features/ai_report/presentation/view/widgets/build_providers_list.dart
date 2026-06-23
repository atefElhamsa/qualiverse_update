import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class BuildProvidersList extends StatelessWidget {
  final AiReportProvidersModel providers;
  final String? selectedProvider;
  final bool isAr;

  const BuildProvidersList({
    super.key,
    required this.providers,
    this.selectedProvider,
    required this.isAr,
  });

  @override
  Widget build(BuildContext context) {
    final list = providers.providers.entries.toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Row(
        children: list.map((entry) {
          final String name = entry.key;
          final ProviderConfig config = entry.value;
          final bool isSelected =
              selectedProvider?.toLowerCase() == name.toLowerCase();

          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: AiReportStatusProviderCard(
                name: name,
                config: config,
                isSelected: isSelected,
                isAr: isAr,
                onTap: () {
                  context.read<AiReportStatusCubit>().selectProvider(name);
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
