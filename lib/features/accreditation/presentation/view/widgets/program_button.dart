import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class ProgramButton extends StatelessWidget {
  const ProgramButton({
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 80.h,
          width: 198.w,
          child: CustomButton(
            buttonModel: ButtonModel(
              onPressed: () {
                typesCubit.changeIndex(0);
                context.pushNamed(AppRoutes.departmentScreen);
              },
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor == AppColors.white
                  ? AppColors.scaffoldLight1
                  : selectedIndex == 0
                  ? AppColors.scaffoldLight1
                  : AppColors.colorButtonDark,
              radius: 20,
              customText: CustomText(
                title: types[1].localizedType(context),
                textStyle: Theme.of(context).textTheme.headlineMedium!,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Image for software accreditation.
        Image.asset(
          Theme.of(context).scaffoldBackgroundColor == AppColors.white
              ? AppImages.softwareAccreditationImageLight
              : AppImages.softwareAccreditationImageDark,
          height: 84.h,
          width: 84.w,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
