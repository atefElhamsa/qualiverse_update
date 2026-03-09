import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../routing/all_routes_imports.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentsCubit, DocumentsState>(
      builder: (context, state) {
        if (state is DocumentsLoaded) {
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
