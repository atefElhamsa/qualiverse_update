import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/ai_report/data/models/ai_report_status_model.dart';
import 'package:qualiverse/features/login/presentation/view/widgets/error_widget.dart';

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
  bool _isExpanded = false;

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
        logoIcon = Icons.psychology_rounded;
        brandColor = const Color(0xFF64B5F6);
        break;
      case 'openai':
        logoIcon = Icons.bolt_rounded;
        brandColor = const Color(0xFF10B981);
        break;
      case 'anthropic':
        logoIcon = Icons.psychology_alt_rounded;
        brandColor = const Color(0xFFF59E0B);
        break;
      case 'google':
        logoIcon = Icons.auto_awesome_rounded;
        brandColor = const Color(0xFF4285F4);
        break;
      case 'ollama':
        logoIcon = Icons.dns_rounded;
        brandColor = const Color(0xFF1E293B);
        break;
      default:
        logoIcon = Icons.api_rounded;
        brandColor = AppColors.colorButtonLight;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isConfigured
              ? (isSelected ? const Color(0xFFF3F8FF) : Colors.white)
              : const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? AppColors.colorButtonLight
                : (isConfigured
                      ? AppColors.green.withOpacity(0.25)
                      : Colors.grey.withOpacity(0.12)),
            width: isSelected ? 2.r : 1.r,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.colorButtonLight.withOpacity(0.08),
                blurRadius: 16.r,
                offset: const Offset(0, 4),
              )
            else if (isConfigured)
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8.r,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          children: [
            InkWell(
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
              borderRadius: BorderRadius.circular(20.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  children: [
                    // Brand Icon
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: isConfigured
                            ? brandColor.withOpacity(0.12)
                            : Colors.grey.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        logoIcon,
                        color: isConfigured ? brandColor : Colors.grey,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    // Model Name and Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                name.toUpperCase(),
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: isConfigured
                                          ? AppColors.mainBlack
                                          : Colors.grey.shade400,
                                      fontSize: 16.sp,
                                    ),
                              ),
                              SizedBox(width: 8.w),
                              if (isSelected)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.colorButtonLight
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Text(
                                    isAr ? "نشط" : "Active",
                                    style: TextStyle(
                                      color: AppColors.colorButtonLight,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                )
                              else if (isConfigured)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Text(
                                    isAr ? "مُعدّ" : "Configured",
                                    style: TextStyle(
                                      color: AppColors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            config.model,
                            style: TextStyle(
                              color: isConfigured
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade400,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Trailing: Selection Radio / Padlock
                    if (!isConfigured)
                      Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.grey.shade400,
                        size: 20.sp,
                      )
                    else
                      AnimatedContainer(
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
                      ),
                    SizedBox(width: 8.w),
                    // Expand arrow
                    IconButton(
                      icon: AnimatedRotation(
                        duration: const Duration(milliseconds: 200),
                        turns: _isExpanded ? 0.5 : 0.0,
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: isConfigured
                              ? AppColors.colorButtonLight
                              : Colors.grey.shade400,
                          size: 24.sp,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Expansion Details
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    SizedBox(height: 12.h),
                    _buildDetailRow(
                      context,
                      label: isAr ? "النموذج" : "Model Name",
                      value: config.model,
                    ),
                    if (config.baseUrl != null) ...[
                      SizedBox(height: 8.h),
                      _buildDetailRow(
                        context,
                        label: isAr ? "عنوان الخدمة" : "Base URL",
                        value: config.baseUrl!,
                      ),
                    ],
                  ],
                ),
              ),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: AppColors.mainBlack),
          ),
        ),
      ],
    );
  }
}
