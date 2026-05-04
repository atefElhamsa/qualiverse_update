import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_filters_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/view/widgets/dashboard_body.dart';
import 'package:qualiverse/features/home/presentation/view/widgets/main_wrapper.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DashboardCubit()..getDashboard()),
        BlocProvider(create: (context) => DashboardFiltersCubit()),
      ],
      child: const MainWrapper(child: DashboardBody()),
    );
  }
}
