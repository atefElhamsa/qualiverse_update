import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiReportStatusProviderCard extends StatefulWidget {
  final String name;
  final ProviderConfig config;
  final bool isSelected;
  final bool isAr;
  final VoidCallback onTap;

  const AiReportStatusProviderCard({
    super.key,
    required this.name,
    required this.config,
    required this.isSelected,
    required this.isAr,
    required this.onTap,
  });

  @override
  State<AiReportStatusProviderCard> createState() =>
      _AiReportStatusProviderCardState();
}

class _AiReportStatusProviderCardState
    extends State<AiReportStatusProviderCard> {
  String _getBadgeText(String name, bool isAr) {
    switch (name.toLowerCase()) {
      case 'openai':
        return isAr ? "موصى به" : "Recommended";
      case 'ollama':
        return isAr ? "نماذج محلية" : "Local Models";
      case 'cohere':
        return isAr ? "موثوق وآمن" : "Secure";
      default:
        return isAr ? "قريباً" : "Soon";
    }
  }

  Color _getBadgeColor(String name) {
    if (name.toLowerCase() == 'openai') return AppColors.green;
    return Colors.grey.shade500;
  }

  String _getBottomText(
    String name,
    ProviderConfig config,
    bool isAr,
    bool isConfigured,
  ) {
    if (name.toLowerCase() == 'openai') {
      return isAr ? "الأسرع والأكثر استقراراً" : "Fastest & Most Stable";
    }
    if (!isConfigured) {
      return config.model.isNotEmpty
          ? config.model
          : (isAr ? "قريباً" : "Soon");
    }
    return config.model;
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.name;
    final config = widget.config;
    final isSelected = widget.isSelected;
    final isAr = widget.isAr;
    final isConfigured = config.configured;

    IconData logoIcon;
    Color brandColor;

    switch (name.toLowerCase()) {
      case 'cohere':
        logoIcon = Icons.copyright_rounded;
        brandColor = const Color(0xFF673AB7);
        break;
      case 'openai':
        logoIcon = Icons.data_object_rounded;
        brandColor = const Color(0xFF10B981);
        break;
      case 'anthropic':
      case 'google':
        logoIcon = Icons.lock_outline_rounded;
        brandColor = Colors.grey.shade400;
        break;
      case 'ollama':
        logoIcon = Icons.pets_rounded;
        brandColor = const Color(0xFF10B981);
        break;
      default:
        logoIcon = Icons.api_rounded;
        brandColor = AppColors.colorButtonLight;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: isConfigured
            ? widget.onTap
            : () {
                showSnackBar(
                  context,
                  isAr
                      ? "هذا المزود غير مفعّل على الخادم حالياً."
                      : "This provider is not configured on the server currently.",
                  AppColors.red,
                );
              },
        borderRadius: BorderRadius.circular(16.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFF3F8FF) : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.colorButtonLight
                  : const Color(0xFFEEEEEE),
              width: isSelected ? 2.r : 1.r,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top row: Radio / Lock
              Align(
                alignment: AlignmentDirectional.topStart,
                child: isConfigured
                    ? AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.all(2.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.colorButtonLight
                                : Colors.grey.shade400,
                            width: 2.r,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 6.r,
                          backgroundColor: isSelected
                              ? AppColors.colorButtonLight
                              : Colors.transparent,
                        ),
                      )
                    : Icon(
                        Icons.circle_outlined,
                        color: Colors.grey.shade300,
                        size: 20.sp,
                      ),
              ),
              SizedBox(height: 8.h),
              // Brand Icon
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: isConfigured
                      ? brandColor.withOpacity(0.12)
                      : Colors.grey.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  logoIcon,
                  color: isConfigured ? brandColor : Colors.grey.shade400,
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 16.h),
              // Provider Name
              Text(
                name.isEmpty
                    ? name
                    : name[0].toUpperCase() + name.substring(1).toLowerCase(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainBlack,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 8.h),
              // Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getBadgeColor(name).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  _getBadgeText(name, isAr),
                  style: TextStyle(
                    color: _getBadgeColor(name),
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              // Bottom Text
              Text(
                _getBottomText(name, config, isAr, isConfigured),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
