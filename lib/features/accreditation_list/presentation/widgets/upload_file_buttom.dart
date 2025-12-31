import 'package:flutter/material.dart';
import 'package:qualiverse/core/utils/app_colors.dart';

class UploadFileButtom extends StatefulWidget {
  const UploadFileButtom({super.key});

  @override
  State<UploadFileButtom> createState() => _UploadFileButtomState();
}

class _UploadFileButtomState extends State<UploadFileButtom> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 51,
      child: ElevatedButton(
        onPressed: () {},
        onHover: (isHovered) {
          setState(() {
            _isHovered = isHovered;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _isHovered
              ? Theme.of(context).scaffoldBackgroundColor == AppColors.white
                    ? AppColors.buttonUploadFileHoverd
                    : AppColors.white
              : AppColors.colorButtonLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          "Upload File",
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
                ? AppColors.white
                : AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
