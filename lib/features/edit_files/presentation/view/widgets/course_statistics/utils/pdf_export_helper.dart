import 'dart:io';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qualiverse/routing/all_routes_imports.dart';

class PdfExportHelper {
  static Future<void> generateAndPrintAnalysisPdf(
    BuildContext context,
    GetFileDataModel data,
    Uint8List imageBytes,
  ) async {
    final pdf = pw.Document();

    final decodedImage = await decodeImageFromList(imageBytes);
    final imageWidth = decodedImage.width.toDouble();
    final imageHeight = decodedImage.height.toDouble();

    final image = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(imageWidth, imageHeight),
        margin: pw.EdgeInsets.zero,
        build: (pw.Context pdfContext) {
          return pw.Image(image, fit: pw.BoxFit.fill);
        },
      ),
    );

    final bytes = await pdf.save();

    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: context.locale.languageCode == 'ar' 
          ? 'اختر مكان حفظ الملف' 
          : 'Choose where to save the file',
      fileName: '${data.courseName}_analysis.pdf',
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (outputFile != null) {
      final file = File(outputFile);
      await file.writeAsBytes(bytes);

      if (context.mounted) {
        final message = context.locale.languageCode == 'ar' 
            ? 'تم حفظ الملف بنجاح' 
            : 'File saved successfully';
        showSnackBar(context, message, Colors.green);
      }
    }
  }
}
