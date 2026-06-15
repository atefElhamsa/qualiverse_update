import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiDescriptionBody extends StatelessWidget {
  final int courseId;
  const AiDescriptionBody({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiDescriptionCubit, AiDescriptionState>(
      listener: _onStateChanged,
      builder: (context, state) {
        final cubit = context.read<AiDescriptionCubit>();
        final bool isProcessing =
            state is AiDescriptionUploadLoading ||
            state is AiDescriptionConfirmLoading;

        return CustomScaffold(
          widget: Stack(
            children: [
              _buildMainContent(context, cubit),
              if (isProcessing) const AiDescriptionLoadingOverlay(),
            ],
          ),
        );
      },
    );
  }

  // --- Logic & Event Handlers ---

  void _onStateChanged(BuildContext context, AiDescriptionState state) {
    if (state is AiDescriptionStartError) {
      showSnackBar(context, state.message, AppColors.red);
    } else if (state is AiDescriptionUploadError) {
      showSnackBar(context, state.message, AppColors.red);
    } else if (state is AiDescriptionConfirmSuccess) {
      context.pushReplacementNamed(AppRoutes.aiDescriptionResultScreen);
    } else if (state is AiDescriptionConfirmError) {
      showSnackBar(context, state.message, AppColors.red);
    }
  }

  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AiDescriptionConfirmDialog(
        onConfirm: () => context.read<AiDescriptionCubit>().confirmAiFiles(),
      ),
    );
  }

  Future<void> _pickFile(BuildContext context, bool isProgram) async {
    final cubit = context.read<AiDescriptionCubit>();
    if (!cubit.isGenerationStarted) {
      showSnackBar(
        context,
        "pleaseClickStartBeforeUploading".tr(),
        AppColors.red,
      );
      return;
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'doc'],
    );
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      isProgram
          ? cubit.updateProgramFile(file)
          : cubit.updateTemplateFile(file);
    }
  }

  // --- UI Layout Sections ---

  Widget _buildMainContent(BuildContext context, AiDescriptionCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AiDescriptionTop(),
        const AiDescriptionWarningMessage(),
        SizedBox(height: 15.h),
        AiDescriptionFileUploadSection(
          onPickProgram: () => _pickFile(context, true),
          onPickTemplate: () => _pickFile(context, false),
          programFile: cubit.programFile,
          templateFile: cubit.templateFile,
        ),
        SizedBox(height: 15.h),
        AiDescriptionBottomActionBar(
          courseId: courseId,
          cubit: cubit,
          onApprovedPressed: () => _showConfirmDialog(context),
        ),
      ],
    );
  }
}
