import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadOptionsSheet extends StatelessWidget {
  final AiDescriptionCubit cubit;

  const DownloadOptionsSheet({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildOption(
          context,
          icon: Icons.picture_as_pdf,
          color: AppColors.red,
          title: "Download PDF",
          onTap: () {
            Navigator.pop(context);
            if (cubit.pdfUrl != null) {
              _launchUrl(cubit.pdfUrl!);
            } else {
              cubit.downloadFile(1);
            }
          },
        ),
        _buildOption(
          context,
          icon: Icons.description,
          color: AppColors.blue,
          title: "Download DOCX",
          onTap: () {
            Navigator.pop(context);
            if (cubit.docxUrl != null) {
              _launchUrl(cubit.docxUrl!);
            } else {
              cubit.downloadFile(0);
            }
          },
        ),
      ],
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      onTap: onTap,
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
