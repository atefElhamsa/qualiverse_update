import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

// Define AccreditationBody class, a stateless widget.
class AccreditationBody extends StatelessWidget {
  // Constructor for AccreditationBody.
  const AccreditationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    // Return a CustomScaffold widget.
    return BlocProvider(
      create: (context) => TypesCubit()..fetchTypes(),
      child: CustomScaffold(
        // Define the widget property with a Column.
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add CustomScaffoldTop widget.
            CustomScaffoldTop(controller: inherited.controller),
            const SizedBox(height: 10),
            // Add AccreditationDefinition widget.
            const AccreditationDefinition(),
            const SizedBox(height: 20),
            // Add AccreditationBottomBody widget.
            const AccreditationBottomBody(),
          ],
        ),
      ),
    );
  }
}
