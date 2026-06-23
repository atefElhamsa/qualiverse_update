import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AiDescriptionTop extends StatelessWidget {
  const AiDescriptionTop({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280.h,
      child: Stack(
        children: [
          BlocBuilder<AiDescriptionCubit, AiDescriptionState>(
            builder: (context, state) {
              final cubit = context.read<AiDescriptionCubit>();
              return FirstTermTop(isDisabled: cubit.currentPage == 5);
            },
          ),
          Positioned(
            top: 80.h,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds),
                  child: Text(
                    "aiModel".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 42.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.2,
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF0D47A1).withOpacity(0.08),
                        const Color(0xFF1976D2).withOpacity(0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(
                      color: const Color(0xFF0D47A1).withOpacity(0.15),
                      width: 1.2,
                    ),
                  ),
                  child: Text(
                    title.tr().toUpperCase(),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 18.sp,
                      color: const Color(0xFF0D47A1),
                      fontWeight: FontWeight.w800,
                      letterSpacing: context.locale.languageCode == 'ar'
                          ? 0
                          : 3.0,
                      height: context.locale.languageCode == 'ar' ? 1.4 : 1.1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
