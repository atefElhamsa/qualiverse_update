import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_dialog.dart';
import 'package:qualiverse/core/shared_widgets/custom_base_drop_down.dart';
import '../../../../../../../../../routing/all_routes_imports.dart';

void showCreateCourseDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const CreateCourseDialog(),
  );
}

class CreateCourseDialog extends StatefulWidget {
  const CreateCourseDialog({super.key});

  @override
  State<CreateCourseDialog> createState() => _CreateCourseDialogState();
}

class _CreateCourseDialogState extends State<CreateCourseDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int? _selectedDeptId;
  int? _selectedLevelId;
  int? _selectedSemesterId;
  List<CourseModel> _availableCourses = [];
  CourseModel? _selectedCourse;
  bool _isLoadingCourses = false;

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _arabicNameController = TextEditingController();
  final TextEditingController _englishNameController = TextEditingController();

  void _fetchCourses() async {
    if (_selectedDeptId == null || _selectedLevelId == null || _selectedSemesterId == null) return;

    setState(() => _isLoadingCourses = true);
    try {
      final yearId = AcademicYearCubit.get(context).selectedAcademicYear?.id ?? 0;
      final courses = await CourseService.getCourses(
        yearId: yearId,
        levelId: _selectedLevelId!,
        semesterId: _selectedSemesterId!,
        departmentId: _selectedDeptId!,
      );
      setState(() {
        _availableCourses = courses;
        _isLoadingCourses = false;
        _selectedCourse = null;
      });
    } catch (e) {
      setState(() => _isLoadingCourses = false);
      if (mounted) showSnackBar(context, e.toString(), AppColors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _codeController.dispose();
    _arabicNameController.dispose();
    _englishNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Create Course',
      maxWidth: 700.w,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterRow(context),
          SizedBox(height: 20.h),
          _buildTabBar(),
          SizedBox(height: 20.h),
          SizedBox(
            height: 250.h,
            child: TabBarView(
              controller: _tabController,
              children: [_buildFromExistsTab(), _buildNewCourseTab()],
            ),
          ),
        ],
      ),
      actions: [
        _buildActionButton(
          title: 'Cancel',
          onPressed: () => Navigator.pop(context),
          backgroundColor: AppColors.grey.withOpacity(0.1),
          textColor: AppColors.mainBlack,
        ),
        _buildActionButton(
          title: 'Create Course',
          onPressed: () {},
          backgroundColor: AppColors.blue,
          textColor: AppColors.white,
          isBold: true,
        ),
      ],
    );
  }

  Widget _buildFilterRow(BuildContext context) {
    final year = AcademicYearCubit.get(context).selectedAcademicYear?.yearNumber.toString() ?? '2025';
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CoursesDepartmentDropDownWidget(
            height: 45.h,
            isExpanded: true,
            selectedId: _selectedDeptId,
            onChanged: (id) => setState(() {
              _selectedDeptId = id;
              _fetchCourses();
            }),
          ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: LevelDropDownWidget(
            height: 45.h,
            isExpanded: true,
            selectedId: _selectedLevelId,
            onChanged: (id) => setState(() {
              _selectedLevelId = id;
              _fetchCourses();
            }),
          ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: SemesterDropDownWidget(
            height: 45.h,
            isExpanded: true,
            selectedId: _selectedSemesterId,
            onChanged: (id) => setState(() {
              _selectedSemesterId = id;
              _fetchCourses();
            }),
          ),
        ),
        SizedBox(width: 12.w),
        _buildAcademicYearInfo(year),
      ],
    );
  }

  Widget _buildAcademicYearInfo(String year) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            title: 'Academic Year',
            textStyle: TextStyle(fontSize: 11.sp, color: AppColors.greyLight),
          ),
          CustomText(
            title: year,
            textStyle: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.mainBlack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.grey.withOpacity(0.2))),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.blue,
        unselectedLabelColor: AppColors.greyLight,
        indicatorColor: AppColors.blue,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.normal),
        tabs: const [Tab(text: 'From Exists'), Tab(text: 'New Course')],
      ),
    );
  }

  Widget _buildFromExistsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Select Course'),
        SizedBox(height: 10.h),
        CustomBaseDropDown<CourseModel>(
          items: _availableCourses,
          itemLabelBuilder: (course) => course.name,
          itemValueBuilder: (course) => course,
          value: _selectedCourse,
          hint: 'Select Course',
          isLoading: _isLoadingCourses,
          prefixIcon: Icon(Icons.search, color: AppColors.greyLight, size: 20.sp),
          height: 45.h,
          onChanged: (val) => setState(() => _selectedCourse = val as CourseModel?),
        ),
      ],
    );
  }

  Widget _buildNewCourseTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildFormField(label: 'Code', hint: 'e.g., CS101', controller: _codeController),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: _buildFormField(
                  label: 'Course Name (Arabic)',
                  hint: 'e.g., Advanced Database',
                  controller: _arabicNameController,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildFormField(
            label: 'Course Name (English)',
            hint: 'e.g., Advanced Database',
            controller: _englishNameController,
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return RichText(
      text: TextSpan(
        text: '$label ',
        style: TextStyle(fontSize: 14.sp, color: AppColors.mainBlack, fontWeight: FontWeight.w500),
        children: [TextSpan(text: '*', style: TextStyle(color: AppColors.red, fontSize: 14.sp))],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        SizedBox(height: 8.h),
        Container(
          height: 45.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.blue.withOpacity(0.2), width: 1.2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: TextField(
              controller: controller,
              style: TextStyle(fontSize: 14.sp, color: AppColors.mainBlack),
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.greyLight),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String title,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
    bool isBold = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        backgroundColor: backgroundColor,
        elevation: backgroundColor == AppColors.blue ? 3 : 0,
        shadowColor: backgroundColor == AppColors.blue ? AppColors.blue.withOpacity(0.4) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
      child: CustomText(
        title: title,
        textStyle: TextStyle(
          color: textColor,
          fontSize: 14.sp,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

