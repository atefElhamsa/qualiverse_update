import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class ItemEvidenceFolderWidget extends StatelessWidget {
  const ItemEvidenceFolderWidget({
    super.key,
    required this.itemFolderModel,
    required this.evidenceFolderModel,
  });

  final ItemFolderModel itemFolderModel;
  final EvidenceFolderModel evidenceFolderModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 765.w,
      height: 122.h,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
            ? AppColors.grey
            : AppColors.mainBlack,
        boxShadow: [
          BoxShadow(
            color: AppColors.mainBlack.withOpacity(0.25),
            offset: const Offset(0, 4),
            spreadRadius: 0,
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: ListTile(
          leading: Image.asset(itemFolderModel.image),
          title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CustomText(
              title: evidenceFolderModel.name,
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 24.sp),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CustomText(
              title: evidenceFolderModel.description,
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
            ),
          ),
          onTap: () {},
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.greyIcon,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}
