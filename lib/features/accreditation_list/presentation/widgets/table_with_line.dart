import 'package:flutter/widgets.dart';
import 'package:qualiverse/features/accreditation_list/presentation/widgets/line.dart';
import 'package:qualiverse/features/accreditation_list/presentation/widgets/table_of_files.dart';

class TableWithLine extends StatelessWidget {
  const TableWithLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Line(), SizedBox(height: 16), TableOfFiles()],
        ),
      ),
    );
  }
}
