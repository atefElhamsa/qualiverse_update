import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class InstitutionalButton extends StatelessWidget {
  const InstitutionalButton({
    super.key,
    required this.typesCubit,
    required this.selectedIndex,
    required this.types,
  });

  final TypesCubit typesCubit;
  final int selectedIndex;
  final List<TypeModel> types;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80.h,
          width: 248.w,
          child: CustomButton(
            buttonModel: ButtonModel(
              onPressed: () {
                typesCubit.changeIndex(1);
                context.pushNamed(AppRoutes.institutionalAccreditationScreen);
              },
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor == AppColors.white
                  ? AppColors.colorButtonLight
                  : selectedIndex == 1
                  ? AppColors.scaffoldLight1
                  : AppColors.colorButtonDark,
              radius: 20,
              customText: CustomText(
                title: types[0].localizedType(context),
                textStyle: Theme.of(context).textTheme.headlineMedium!,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Image.asset(
          Theme.of(context).scaffoldBackgroundColor == AppColors.white
              ? AppImages.institutionalAccreditationImageLight
              : AppImages.institutionalAccreditationImageDark,
          height: 84.h,
          width: 84.w,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
