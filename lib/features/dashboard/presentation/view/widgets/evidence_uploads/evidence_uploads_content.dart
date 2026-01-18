import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceUploadsContent extends StatelessWidget {
  const EvidenceUploadsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Image.asset(
          AppImages.evidenceUploadImage,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
