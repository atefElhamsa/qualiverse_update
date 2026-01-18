import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';

class DropButtonList extends StatefulWidget {
  const DropButtonList({super.key});

  @override
  State<DropButtonList> createState() => _DropButtonListState();
}

class _DropButtonListState extends State<DropButtonList> {
  String? accreditationValue;
  String? levelValue;
  String? yearValue;
  String? departmentValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        spacing: 13.h,
        children: [
          CustomFilterDropdown<String>(
            hint: 'Accreditation',
            value: accreditationValue,
            items: const [
              DropdownMenuItem(value: 'a', child: Text('Accreditation A')),
              DropdownMenuItem(value: 'b', child: Text('Accreditation B')),
            ],
            onChanged: (v) {
              setState(() {
                accreditationValue = v;
              });
            },
          ),

          const SizedBox(height: 12),

          CustomFilterDropdown<String>(
            hint: 'Level',
            value: levelValue,
            items: const [
              DropdownMenuItem(value: '1', child: Text('Level 1')),
              DropdownMenuItem(value: '2', child: Text('Level 2')),
            ],
            onChanged: (v) {
              setState(() {
                levelValue = v;
              });
            },
          ),

          const SizedBox(height: 12),

          CustomFilterDropdown<String>(
            hint: 'Year',
            value: yearValue,
            items: const [
              DropdownMenuItem(value: '2024', child: Text('2024')),
              DropdownMenuItem(value: '2025', child: Text('2025')),
            ],
            onChanged: (v) {
              setState(() {
                yearValue = v;
              });
            },
          ),

          const SizedBox(height: 12),

          CustomFilterDropdown<String>(
            hint: 'Department Name',
            value: departmentValue,
            items: const [
              DropdownMenuItem(value: 'cs', child: Text('Computer Science')),
              DropdownMenuItem(
                value: 'it',
                child: Text('Information Technology'),
              ),
            ],
            onChanged: (v) {
              setState(() {
                departmentValue = v;
              });
            },
          ),
        ],
      ),
    );
  }
}
