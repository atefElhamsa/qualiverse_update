import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../routing/all_routes_imports.dart';

class LanguageItem extends StatelessWidget {
  final int index;
  final AppLanguage language;
  final bool isAppLanguage;

  const LanguageItem({
    super.key,
    required this.index,
    required this.language,
    required this.isAppLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListTile(
              leading: CustomText(
                title: '${index + 1}.',
                textStyle: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mainBlack,
                ),
              ),
              title: CustomText(
                title: language.name.tr(),
                textStyle: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mainBlack,
                ),
              ),
              subtitle: isAppLanguage
                  ? CustomText(
                      title: "appLanguageDescription".tr(),
                      textStyle: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainBlack,
                      ),
                    )
                  : null,
              trailing: PopupMenuButton<LanguageAction>(
                tooltip: '',
                offset: const Offset(0, 40),
                color: AppColors.customContainerSettingColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                itemBuilder: (context) {
                  return [
                    if (!isAppLanguage)
                      PopupMenuItem(
                        value: LanguageAction.change,
                        child: CustomText(
                          title: "use_as_app_language".tr(),
                          textStyle: Theme.of(context).textTheme.bodySmall!,
                        ),
                      ),
                    if (!isAppLanguage)
                      PopupMenuItem(
                        value: LanguageAction.remove,
                        child: CustomText(
                          title: "remove".tr(),
                          textStyle: Theme.of(context).textTheme.bodySmall!,
                        ),
                      ),
                  ];
                },
                onSelected: (action) {
                  final cubit = SettingCubit.get(context);

                  if (action == LanguageAction.change) {
                    cubit.changeLanguage(lang: language.code, context: context);
                  } else if (action == LanguageAction.remove) {
                    cubit.removePreferredLanguage(language.code);
                  }
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.grey,
                    ),
                    child: const Icon(Icons.more_vert),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum LanguageAction { change, remove }
