import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets_model/drop_button_model.dart';

// A customizable dropdown button widget.
class CustomDropButton extends StatelessWidget {
  // Constructor for CustomDropButton.
  const CustomDropButton({super.key, required this.dropButtonModel});

  // Model containing data and behavior for the dropdown button.
  final DropButtonModel dropButtonModel;

  // Creates the mutable state for this widget.
  // Builds the UI for the CustomDropButton.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 592.w,
      child: DropdownButton2(
        isExpanded: true,
        value: dropButtonModel.selectedData,
        // Removes the default underline.
        underline: const SizedBox(),
        // Hint text displayed when no item is selected.
        hint: Text(
          dropButtonModel.hintText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: TextStyle(fontSize: dropButtonModel.hintSize),
        ),
        // List of items to display in the dropdown.
        items: dropButtonModel.listOfData.map((department) {
          return DropdownMenuItem(
            value: department,
            child: Text(
              department.toString(),
              style: TextStyle(fontSize: dropButtonModel.hintSize),
            ),
          );
        }).toList(),
        // Callback when an item is selected.
        // Updates the selectedData in the dropButtonModel.
        onChanged: dropButtonModel.onChanged,
        buttonStyleData: ButtonStyleData(
          height: 58.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondaryFixed,
            // Rounded corners for the button.
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(
              color: Theme.of(context).colorScheme.onSecondaryFixed,
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          // Offset for the dropdown menu.
          offset: Offset(0, -10.h),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondaryFixed,
            // Rounded corners for the dropdown menu.
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: Theme.of(context).colorScheme.onSecondaryFixed,
            ),
          ),
        ),
      ),
    );
  }
}
