import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AccreditationBottomBody extends StatelessWidget {
  const AccreditationBottomBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TypesCubit, TypesState>(
      builder: (context, state) {
        if (state is TypesLoading) {
          return const CustomLoading();
        }
        if (state is TypesError) {
          return RetryWidget(
            title: state.message,
            onPressed: () {
              TypesCubit.get(context).fetchTypes();
            },
          );
        }
        if (state is TypesSuccess) {
          final typesCubit = TypesCubit.get(context);
          int selectedIndex = typesCubit.selectedIndex;
          List<TypeModel> types = state.types;
          return Center(
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProgramButton(
                    typesCubit: typesCubit,
                    selectedIndex: selectedIndex,
                    types: types,
                  ),
                  const SizedBox(width: 90),
                  InstitutionalButton(
                    typesCubit: typesCubit,
                    selectedIndex: selectedIndex,
                    types: types,
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
