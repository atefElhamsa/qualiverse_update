import 'package:flutter/material.dart';

import '../../../../../routing/all_routes_imports.dart';

class AnalysisFilesNewButton extends StatefulWidget {
  const AnalysisFilesNewButton({super.key});

  @override
  State<AnalysisFilesNewButton> createState() => _AnalysisFilesNewButtonState();
}

class _AnalysisFilesNewButtonState extends State<AnalysisFilesNewButton> {
  OverlayEntry? menuOverlay;
  final LayerLink layerLink = LayerLink();

  @override
  void dispose() {
    removeMenu();
    super.dispose();
  }

  void toggleMenu() {
    menuOverlay == null ? showMenu() : removeMenu();
  }

  void removeMenu() {
    if (menuOverlay != null) {
      menuOverlay!.remove();
      menuOverlay = null;
    }
  }

  void showMenu() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || menuOverlay != null) return;

      menuOverlay = OverlayEntry(
        builder: (_) => MenuOverlay(
          layerLink: layerLink,
          onDismiss: removeMenu,
          onItemSelected: onMenuItemSelected,
        ),
      );

      Overlay.of(context).insert(menuOverlay!);
    });
  }

  void onMenuItemSelected(String value) {
    removeMenu();

    switch (value) {
      case 'new_folder':
        debugPrint('New Folder');
        break;
      case 'upload_folder':
        debugPrint('Upload Folder');
        break;
      case 'upload_file':
        debugPrint('Upload File');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: NewButton(onTap: toggleMenu, title: "uploadEvidence"),
    );
  }
}
