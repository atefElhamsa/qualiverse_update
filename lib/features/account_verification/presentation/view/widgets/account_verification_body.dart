import 'package:flutter/material.dart';

import '../../../../../routing/all_routes_imports.dart';

class AccountVerificationBody extends StatelessWidget {
  const AccountVerificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        WhiteContainerWidget(),
        AccountVerificationDetails(),
        DotsWidget(),
        AccountVerificationTop(),
      ],
    );
  }
}
