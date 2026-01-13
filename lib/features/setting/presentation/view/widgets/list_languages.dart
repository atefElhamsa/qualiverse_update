import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class ListLanguages extends StatelessWidget {
  const ListLanguages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        final cubit = SettingCubit.get(context);

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cubit.preferredLanguages.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final lang = cubit.preferredLanguages[index];
            final isAppLanguage = lang.code == cubit.languageCode;

            return LanguageItem(
              index: index,
              language: lang,
              isAppLanguage: isAppLanguage,
            );
          },
        );
      },
    );
  }
}
