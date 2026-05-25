import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routing/all_routes_imports.dart';

class CustomDropButton extends StatelessWidget {
  const CustomDropButton({super.key, required this.dropButtonModel});

  final DropButtonModel dropButtonModel;

  @override
  Widget build(BuildContext context) {
    final isValueInItems = dropButtonModel.listOfData.contains(
      dropButtonModel.selectedData,
    );
    final shouldShowClear = dropButtonModel.showClearButton && isValueInItems;

    return SizedBox(
      width: 592.w,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          DropdownButton2(
            isExpanded: true,
            value: isValueInItems ? dropButtonModel.selectedData : null,
            underline: const SizedBox(),
            hint: Text(
              dropButtonModel.hintText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.almarai(
                fontSize: dropButtonModel.hintSize ?? 15.sp,
                color: Colors.grey[700],
              ),
            ),
            items: dropButtonModel.listOfData.map((data) {
              final isItemDisabled =
                  dropButtonModel.disabledItems?.contains(data) ?? false;
              return DropdownMenuItem(
                value: data,
                enabled: !isItemDisabled,
                child: Text(
                  data.toString(),
                  style: GoogleFonts.almarai(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: isItemDisabled
                        ? Colors.grey.shade400
                        : AppColors.mainBlack,
                  ),
                ),
              );
            }).toList(),
            onChanged: dropButtonModel.onChanged,
            buttonStyleData: ButtonStyleData(
              height: 55.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
              ),
            ),
            iconStyleData: IconStyleData(
              icon: shouldShowClear
                  ? const SizedBox()
                  : const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.grey,
                    ),
            ),
            dropdownStyleData: DropdownStyleData(
              offset: Offset(0, -5.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
            ),
          ),
          if (shouldShowClear)
            Positioned(
              right: 12.w,
              child: GestureDetector(
                onTap: () {
                  if (dropButtonModel.onChanged != null) {
                    dropButtonModel.onChanged!(null);
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(8.w),
                  child: Icon(
                    Icons.clear_rounded,
                    color: Colors.grey[600],
                    size: 20.sp,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
