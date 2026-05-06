import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/shared_widgets_model/drop_button_model.dart';

class CustomDropButton extends StatelessWidget {
  const CustomDropButton({super.key, required this.dropButtonModel});

  final DropButtonModel dropButtonModel;

  @override
  Widget build(BuildContext context) {
    final isValueInItems = dropButtonModel.listOfData.contains(
      dropButtonModel.selectedData,
    );

    return SizedBox(
      width: 592.w,
      child: DropdownButton2(
        isExpanded: true,
        value: isValueInItems ? dropButtonModel.selectedData : null,
        underline: const SizedBox(),
        hint: Text(
          dropButtonModel.hintText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.tajawal(
            fontSize: dropButtonModel.hintSize ?? 18.sp,
            color: Colors.grey,
          ),
        ),
        items: dropButtonModel.listOfData.map((data) {
          return DropdownMenuItem(
            value: data,
            child: Text(
              data.toString(),
              style: GoogleFonts.tajawal(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }).toList(),
        onChanged: dropButtonModel.onChanged,
        buttonStyleData: ButtonStyleData(
          height: 65.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
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
    );
  }
}
