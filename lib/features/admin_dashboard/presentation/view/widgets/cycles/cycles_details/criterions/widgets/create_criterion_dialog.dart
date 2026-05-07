import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_base_drop_down.dart';
import 'package:qualiverse/core/shared_widgets/custom_dialog.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/view/widgets/cycles/cycles_details/criterions/widgets/create_criterion_dialog_widgets.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import '../../courses/widgets/department_drop_down_widget.dart';
import 'package:easy_localization/easy_localization.dart';

void showCreateCriterionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const CreateCriterionDialog(),
  );
}

class CreateCriterionDialog extends StatefulWidget {
  const CreateCriterionDialog({super.key});

  @override
  State<CreateCriterionDialog> createState() => _CreateCriterionDialogState();
}

class _CreateCriterionDialogState extends State<CreateCriterionDialog>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int? selectedTypeId;
  int? selectedDeptId;
  CriterionTemplateModel? selectedTemplate;
  List<CriterionTemplateModel> availableTemplates = [];
  bool isLoadingTemplates = false;

  final TextEditingController arabicNameController = TextEditingController();
  final TextEditingController englishNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  void _onTypeChanged(int? typeId) {
    setState(() {
      selectedTypeId = typeId;
      selectedTemplate = null;
      availableTemplates = [];
    });

    if (typeId != null) {
      context.read<CriterionsCubit>().fetchTemplateCriteria(
            accreditationTypeId: typeId,
          );
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    arabicNameController.dispose();
    englishNameController.dispose();
    super.dispose();
  }

  void handleCreateCriterion(BuildContext context) {
    if (selectedTypeId == null) {
      showSnackBar(context, 'Please select Accreditation Type', AppColors.red);
      return;
    }

    if (selectedDeptId == null) {
      showSnackBar(context, 'Please select Department', AppColors.red);
      return;
    }

    final yearId = AcademicYearCubit.get(context).selectedAcademicYear?.id;
    if (yearId == null) {
      showSnackBar(context, 'Please select Academic Year', AppColors.red);
      return;
    }

    if (tabController.index == 0) {
      if (selectedTemplate == null) {
        showSnackBar(context, 'Please select a Criterion', AppColors.red);
        return;
      }

      context.read<CriterionsCubit>().createCriterionFromExistingTemplate(
            criterionTemplateId: selectedTemplate!.id,
            accreditationTypeId: selectedTypeId!,
            departmentId: selectedDeptId!,
            academicYearId: yearId,
          );
    } else {
      if (arabicNameController.text.isEmpty ||
          englishNameController.text.isEmpty) {
        showSnackBar(context, 'Please fill all fields', AppColors.red);
        return;
      }

      context.read<CriterionsCubit>().createNewCriterion(
            nameAr: arabicNameController.text,
            nameEn: englishNameController.text,
            accreditationTypeId: selectedTypeId!,
            departmentId: selectedDeptId!,
            academicYearId: yearId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final academicYear =
        AcademicYearCubit.get(
          context,
        ).selectedAcademicYear?.yearNumber.toString() ??
        '2025';

    return CustomDialog(
      title: 'createNewCriterion'.tr(),
      maxWidth: 600.w,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabelWithAsterisk('accreditationType'.tr()),
                    SizedBox(height: 8.h),
                    BlocBuilder<TypesCubit, TypesState>(
                      builder: (context, state) {
                        final types =
                            state is TypesSuccess
                                ? state.types
                                : <TypeModel>[];
                        return CustomBaseDropDown<TypeModel>(
                          items: types,
                          itemLabelBuilder: (t) => t.name,
                          itemValueBuilder: (t) => t.id,
                          value:
                              types
                                  .where((t) => t.id == selectedTypeId)
                                  .firstOrNull,
                          hint: 'selectType'.tr(),
                          height: 45.h,
                          onChanged: (val) => _onTypeChanged(val as int?),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabel('department'.tr()),
                    SizedBox(height: 8.h),
                    CoursesDepartmentDropDownWidget(
                      height: 45.h,
                      isExpanded: true,
                      selectedId: selectedDeptId,
                      useCubitSelection: false,
                      onChanged: (id) => setState(() => selectedDeptId = id),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          CustomText(
            title: '${'academicYear'.tr()}: $academicYear',
            textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.mainBlack,
            ),
          ),
          SizedBox(height: 16.h),
          buildTabBar(tabController),
          SizedBox(height: 16.h),
          SizedBox(
            height: 250.h,
            child: TabBarView(
              controller: tabController,
              children: [
                buildFromExistsTab(),
                buildNewCriterionTab(
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
          backgroundColor: const Color(0xFFE5E7EB),
          textColor: AppColors.mainBlack,
        ),
        BlocListener<CriterionsCubit, CriterionsState>(
          listener: (context, state) {
            if (state is CriterionCreateSuccess) {
              showSnackBar(context, state.message, AppColors.green);
              Navigator.pop(context);
              final yearId =
                  AcademicYearCubit.get(context).selectedAcademicYear?.id;
              if (yearId != null) {
                context.read<CriterionsCubit>().fetchCriterions(
                  academicYearId: yearId,
                );
              }
            } else if (state is CriterionsError) {
              showSnackBar(context, state.message, AppColors.red);
            }
          },
          child: buildActionButton(
            title: 'createCriterion'.tr(),
            onPressed: () => handleCreateCriterion(context),
            backgroundColor: const Color(0xFF2C3E8A),
            textColor: AppColors.white,
            isBold: true,
          ),
        ),
      ],
    );
  }

  Widget buildFromExistsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabelWithAsterisk('selectCriterion'.tr()),
        SizedBox(height: 8.h),
        BlocBuilder<CriterionsCubit, CriterionsState>(
          builder: (context, state) {
            if (state is CriterionsTemplatesSuccess) {
              availableTemplates = state.templates;
              isLoadingTemplates = false;
            } else if (state is CriterionsTemplatesLoading) {
              isLoadingTemplates = true;
            }

            return CustomBaseDropDown<CriterionTemplateModel>(
              items: availableTemplates,
              itemLabelBuilder: (c) => c.name,
              itemValueBuilder: (c) => c,
              value: selectedTemplate,
              hint: 'selectCriterion'.tr(),
              isLoading: isLoadingTemplates,
              height: 45.h,
              onChanged: (val) => setState(
                () => selectedTemplate = val as CriterionTemplateModel?,
              ),
            );
          },
        ),
      ],
    );
  }
}
