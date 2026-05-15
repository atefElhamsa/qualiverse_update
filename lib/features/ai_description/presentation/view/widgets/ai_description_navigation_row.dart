import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiDescriptionNavigationRow extends StatelessWidget {
  const AiDescriptionNavigationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiDescriptionCubit, AiDescriptionState>(
      builder: (context, state) {
        final cubit = context.read<AiDescriptionCubit>();
        bool isRtl = context.locale.languageCode == 'ar';
        
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (cubit.currentPage > 0)
                AiActionButton(
                  title: "back".tr(),
                  icon: isRtl ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded,
                  onTap: () => cubit.previousPage(),
                  isSecondary: true,
                )
              else
                const SizedBox(),
              AiActionButton(
                title: cubit.currentPage < 4 ? "next".tr() : "submit".tr(),
                icon: cubit.currentPage < 4
                    ? (isRtl ? Icons.arrow_back_rounded : Icons.arrow_forward_rounded)
                    : Icons.check_circle_rounded,
                onTap: cubit.currentPage < 4
                    ? () => cubit.nextPage()
                    : () => cubit.submitDetails(),
              ),
            ],
          ),
        );
      },
    );
  }
}
