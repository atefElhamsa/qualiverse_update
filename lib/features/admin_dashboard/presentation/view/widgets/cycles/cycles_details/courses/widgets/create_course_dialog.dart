import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_base_drop_down.dart';
import 'package:qualiverse/core/shared_widgets/custom_dialog.dart';

import '../../../../../../../../../routing/all_routes_imports.dart';
import 'create_course_dialog_widgets.dart';
import 'package:easy_localization/easy_localization.dart';

void showCreateCourseDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const CreateCourseDialog(),
  );
}

class CreateCourseDialog extends StatefulWidget {
  const CreateCourseDialog({super.key});

  @override
  State<CreateCourseDialog> createState() => CreateCourseDialogState();
}

class CreateCourseDialogState extends State<CreateCourseDialog>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int? selectedDeptId;
  int? selectedLevelId;
  int? selectedTermId;
  List<CourseModel> availableCourses = [];
  CourseModel? selectedCourse;
  bool isLoadingCourses = false;

  final TextEditingController codeController = TextEditingController();
  final TextEditingController arabicNameController = TextEditingController();
  final TextEditingController englishNameController = TextEditingController();

  void handleCreateCourse(BuildContext context) {
    final cubit = TemplateCubit.get(context);

    if (selectedDeptId == null ||
        selectedLevelId == null ||
        selectedTermId == null) {
      showSnackBar(
        context,
        'Please select Department, Level and Semester',
        AppColors.red,
      );
      return;
    }

    final yearId = AcademicYearCubit.get(context).selectedAcademicYear?.id ?? 0;

    if (tabController.index == 0) {
      final selectedTemplate = cubit.selectedTemplate;
      if (selectedTemplate == null) {
        showSnackBar(context, 'Please select a Template', AppColors.red);
        return;
      }

      cubit.createCourseFromTemplate(
        templateId: selectedTemplate.id,
        yearId: yearId,
        departmentId: selectedDeptId!,
        levelId: selectedLevelId!,
        termId: selectedTermId!,
      );
    } else if (tabController.index == 1) {
      if (codeController.text.isEmpty ||
          arabicNameController.text.isEmpty ||
          englishNameController.text.isEmpty) {
        showSnackBar(context, 'Please fill all fields', AppColors.red);
        return;
      }

      cubit.createNewCourse(
        nameAr: arabicNameController.text,
        nameEn: englishNameController.text,
        code: codeController.text,
        departmentId: selectedDeptId!,
        levelId: selectedLevelId!,
        termId: selectedTermId!,
        yearId: yearId,
      );
    }
  }

  void fetchCourses() async {
    if (selectedDeptId == null ||
        selectedLevelId == null ||
        selectedTermId == null) {
      return;
    }

    setState(() => isLoadingCourses = true);
    try {
      final yearId =
          AcademicYearCubit.get(context).selectedAcademicYear?.id ?? 0;
      final courses = await CourseService.getCourses(
        yearId: yearId,
        levelId: selectedLevelId!,
        termId: selectedTermId!,
        departmentId: selectedDeptId!,
      );
      setState(() {
        availableCourses = courses.courses!;
        isLoadingCourses = false;
        selectedCourse = null;
      });
    } catch (e) {
      setState(() => isLoadingCourses = false);
      if (mounted) showSnackBar(context, e.toString().replaceFirst('Exception: ', '').trim(), AppColors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    TemplateCubit.get(context).fetchTemplates();
  }

  @override
  void dispose() {
    tabController.dispose();
    codeController.dispose();
    arabicNameController.dispose();
    englishNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'createCourse'.tr(),
      maxWidth: 700.w,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildFilterRow(context),
          SizedBox(height: 20.h),
          buildTabBar(tabController),
          SizedBox(height: 20.h),
          SizedBox(
            height: 250.h,
            child: TabBarView(
              controller: tabController,
              children: [
                buildFromExistsTab(),
                buildNewCourseTab(
                  codeController,
                  arabicNameController,
                  englishNameController,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        buildActionButton(
          title: 'cancel'.tr(),
          onPressed: () => Navigator.pop(context),
          backgroundColor: AppColors.grey.withOpacity(0.1),
          textColor: AppColors.mainBlack,
        ),
        BlocListener<TemplateCubit, TemplateState>(
          listener: (context, state) {
            if (state is CreateCourseFromTemplateSuccess) {
              showSnackBar(context, state.message, AppColors.green);
              Navigator.pop(context);
            } else if (state is CreateNewCourseSuccess) {
              showSnackBar(context, state.message, AppColors.green);
              Navigator.pop(context);
            } else if (state is TemplateError) {
              showSnackBar(context, state.message, AppColors.red);
            }
          },
          child: buildActionButton(
            title: 'createCourse'.tr(),
            onPressed: () => handleCreateCourse(context),
            backgroundColor: AppColors.blue,
            textColor: AppColors.white,
            isBold: true,
          ),
        ),
      ],
    );
  }

  Widget buildFilterRow(BuildContext context) {
    final year =
        AcademicYearCubit.get(
          context,
        ).selectedAcademicYear?.yearNumber.toString() ??
        '2025';
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CoursesDepartmentDropDownWidget(
            height: 45.h,
            isExpanded: true,
            selectedId: selectedDeptId,
            useCubitSelection: false,
            onChanged: (id) => setState(() {
              selectedDeptId = id;
              fetchCourses();
            }),
          ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: LevelDropDownWidget(
            height: 45.h,
            isExpanded: true,
            selectedId: selectedLevelId,
            useCubitSelection: false,
            onChanged: (id) => setState(() {
              selectedLevelId = id;
              fetchCourses();
            }),
          ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: SemesterDropDownWidget(
            height: 45.h,
            isExpanded: true,
            selectedId: selectedTermId,
            useCubitSelection: false,
            onChanged: (id) => setState(() {
              selectedTermId = id;
              fetchCourses();
            }),
          ),
        ),
        SizedBox(width: 12.w),
        buildAcademicYearInfo(year),
      ],
    );
  }

  Widget buildFromExistsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel('selectCourse'.tr()),
        SizedBox(height: 10.h),
        BlocBuilder<TemplateCubit, TemplateState>(
          builder: (context, state) {
            final cubit = TemplateCubit.get(context);

            final isLoading = state is TemplateLoading;
            final templates = state is TemplateLoaded
                ? state.templates
                : <TemplateModel>[];
            final selectedTemplate = state is TemplateLoaded
                ? state.selectedTemplate
                : null;

            return CustomBaseDropDown<TemplateModel>(
              items: templates,
              itemLabelBuilder: (template) => template.name,
              itemValueBuilder: (template) => template,
              value: selectedTemplate,
              hint: 'selectTemplate'.tr(),
              isLoading: isLoading,
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.greyLight,
                size: 20.sp,
              ),
              height: 45.h,
              onChanged: (val) {
                if (val != null) {
                  cubit.selectTemplate(template: val as TemplateModel);
                }
              },
            );
          },
        ),
      ],
    );
  }
}
