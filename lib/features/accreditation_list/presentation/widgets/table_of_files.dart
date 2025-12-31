import 'package:flutter/material.dart';
import 'package:qualiverse/core/utils/app_colors.dart';
import 'package:qualiverse/core/utils/app_texts.dart';
import 'package:qualiverse/features/accreditation_list/data/accreditation_list_files.dart';
import 'package:qualiverse/features/accreditation_list/data/accreditation_list_model.dart';
import 'package:qualiverse/features/accreditation_list/presentation/widgets/upload_file_buttom.dart';

class TableOfFiles extends StatelessWidget {
  const TableOfFiles({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AccreditationListModel> files = FackApi.accreditationListFiles;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Table(
          border: TableBorder.all(color: Colors.transparent),
          columnWidths: const {
            0: FixedColumnWidth(450),
            1: FixedColumnWidth(300),
            2: FixedColumnWidth(450),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            const TableRow(
              decoration: BoxDecoration(color: AppColors.tableColor),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    AppTexts.indicator,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    AppTexts.uploadFile,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    AppTexts.uploadedFiles,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            const TableRow(
              decoration: BoxDecoration(color: Colors.transparent),
              children: [
                SizedBox(height: 4),
                SizedBox(height: 4),
                SizedBox(height: 4),
              ],
            ),
            for (AccreditationListModel file in files) ...[
              TableRow(
                decoration: const BoxDecoration(color: AppColors.tableColor),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      file.nameCourse,
                      style: TextStyle(
                        color: file.nameFile == 'لا يوجد ملف'
                            ? AppColors.mainBlack
                            : AppColors.noFileColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Center(child: UploadFileButtom()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        file.nameFile,
                        style: TextStyle(
                          color: file.nameFile == 'لا يوجد ملف'
                              ? AppColors.mainBlack
                              : AppColors.noFileColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const TableRow(
                decoration: BoxDecoration(color: Colors.transparent),
                children: [
                  SizedBox(height: 4),
                  SizedBox(height: 4),
                  SizedBox(height: 4),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
