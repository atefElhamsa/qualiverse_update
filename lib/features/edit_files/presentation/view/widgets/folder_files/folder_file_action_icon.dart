import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FolderFileActionIcon extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback onTap;

  const FolderFileActionIcon({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onTap,
  });

  @override
  State<FolderFileActionIcon> createState() => _FolderFileActionIconState();
}

class _FolderFileActionIconState extends State<FolderFileActionIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: _hovered
                  ? widget.color.withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(widget.icon, color: widget.color, size: 20.sp),
          ),
        ),
      ),
    );
  }
}
