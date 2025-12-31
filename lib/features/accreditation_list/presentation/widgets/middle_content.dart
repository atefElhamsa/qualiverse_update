import 'dart:math';

import 'package:flutter/widgets.dart';

class MiddleContent extends StatelessWidget {
  const MiddleContent({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(right: max(8, (screenWidth - 1200) / 2)),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                ' المعيار الخامس',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              SizedBox(width: 10),
              Text(' - '),
              SizedBox(width: 10),
              Text(
                'الجهاز اإلداري',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'موشرات مكتملة',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              SizedBox(width: 10),
              Text(
                '4/3',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
