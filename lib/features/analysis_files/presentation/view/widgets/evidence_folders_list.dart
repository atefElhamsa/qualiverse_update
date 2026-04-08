import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class EvidenceFoldersList extends StatelessWidget {
  const EvidenceFoldersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvidenceFolderCubit, EvidenceFolderState>(
      builder: (context, state) {
        if (state is EvidenceFolderLoading) {
          return const CustomLoading();
        }
        if (state is EvidenceFolderError) {
          return RetryWidget(
            title: state.message,
            onPressed: () {
              context.read<EvidenceFolderCubit>().fetchEvidenceFolders();
            },
          );
        }
        if (state is EvidenceFolderSuccess) {
          final evidenceFolders = state.evidenceFolders;
          if (evidenceFolders.isEmpty) {
            return RetryWidget(
              title: 'No Data Found',
              onPressed: () {
                context.read<EvidenceFolderCubit>().fetchEvidenceFolders();
              },
            );
          } else {
            return Column(
              spacing: 30,
              children: List.generate(
                evidenceFolders.length,
                (index) => ItemEvidenceFolderWidget(
                  itemFolderModel: items[index],
                  evidenceFolderModel: evidenceFolders[index],
                ),
              ),
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
