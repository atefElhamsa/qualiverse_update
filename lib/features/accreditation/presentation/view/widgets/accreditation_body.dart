import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AccreditationBody extends StatelessWidget {
  const AccreditationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    return BlocProvider(
      create: (context) => TypesCubit()..fetchTypes(),
      child: CustomScaffold(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomScaffoldTop(controller: inherited.controller),
            const SizedBox(height: 10),
            const AccreditationDefinition(),
            const SizedBox(height: 20),
            const AccreditationBottomBody(),
          ],
        ),
      ),
    );
  }
}
