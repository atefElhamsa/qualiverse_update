import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../routing/all_routes_imports.dart';

class CyclesDetailsScreen extends StatefulWidget {
  const CyclesDetailsScreen({super.key});

  @override
  State<CyclesDetailsScreen> createState() => _CyclesDetailsScreenState();
}

class _CyclesDetailsScreenState extends State<CyclesDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Reset tab to the first one whenever the screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CycleTabsCubit>().changeTab(CycleTab.courses);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CyclesDetailsTopWidget(),
          SizedBox(height: 20),
          CyclesDetailsTapsWidget(),
          CycleDetailsTapsContent(),
        ],
      ),
    );
  }
}
