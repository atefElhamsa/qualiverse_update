import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/features/edit_files/presentation/controller/evidence_folder_files/evidence_folder_files_state.dart';
import 'package:qualiverse/features/edit_files/presentation/controller/get_file_data/get_file_data_state.dart';
import 'package:qualiverse/features/edit_files/presentation/view/widgets/evidence_folder_files/evidence_folder_file_item.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import '../controller/evidence_folder_files/evidence_folder_files_cubit.dart';
import '../controller/get_file_data/get_file_data_cubit.dart';
import 'widgets/course_statistics/course_statistics_dashboard.dart';

class EvidenceFileStatisticsScreen extends StatefulWidget {
  final int academicYearId;
  final int termId;
  final int levelId;
  final int? departmentId;
  final int courseId;

  const EvidenceFileStatisticsScreen({
    super.key,
    required this.academicYearId,
    required this.termId,
    required this.levelId,
    this.departmentId,
    required this.courseId,
  });

  @override
  State<EvidenceFileStatisticsScreen> createState() =>
      _EvidenceFileStatisticsScreenState();
}

class _EvidenceFileStatisticsScreenState
    extends State<EvidenceFileStatisticsScreen>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _searchController;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 1 && !_tabController.indexIsChanging) {
        _refreshFileData();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshFileData(); // Ensure data is fetched even before switching tabs
      EvidenceFolderFilesCubit.get(context).getStatistics(
        academicYearId: widget.academicYearId,
        termId: widget.termId,
        levelId: widget.levelId,
        departmentId: widget.departmentId,
      );
    });
  }

  void _refreshFileData() {
    GetFileDataCubit.get(context).getFileData(
      courseId: widget.courseId,
      academicYearId: widget.academicYearId,
      termId: widget.termId,
      levelId: widget.levelId,
      departmentId: widget.departmentId,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<EvidenceFolderFilesCubit, EvidenceFolderFilesState>(
        listener: (context, state) {
          if (state is UploadEvidenceFilesSuccess) {
            showSnackBar(context, state.message, AppColors.green);
            EvidenceFolderFilesCubit.get(context).getStatistics(
              academicYearId: widget.academicYearId,
              termId: widget.termId,
              levelId: widget.levelId,
              departmentId: widget.departmentId,
            );
            _refreshFileData();
            Future.delayed(const Duration(seconds: 3), () {
              if (mounted) {
                _refreshFileData();
              }
            });
          }
          if (state is UploadEvidenceFilesFailure) {
            showSnackBar(context, state.error, AppColors.red);
          }
        },
        builder: (context, state) {
          final cubit = EvidenceFolderFilesCubit.get(context);
          final isUploading = state is UploadEvidenceFilesLoading;

          return Stack(
            children: [
              Positioned.fill(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, cubit.allFiles.length),
                    _buildTabBar(),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: _buildBody(context, state, cubit),
                              ),
                            ],
                          ),
                          _buildStatisticsAnalysisTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (isUploading)
                Container(
                  color: Colors.white.withOpacity(0.4),
                  child: const Center(child: CustomLoading()),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int count) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1FF),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: const Color(0xFF4285F4),
                  size: 13.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: const Color(0xFF0F569E),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.analytics_rounded,
              color: Colors.white,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'statistics'.tr(),
                style: GoogleFonts.almarai(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              Text(
                '$count ${'files'.tr()}',
                style: GoogleFonts.almarai(
                  fontSize: 13.sp,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildBody(
    BuildContext context,
    EvidenceFolderFilesState state,
    EvidenceFolderFilesCubit cubit,
  ) {
    if (state is EvidenceFolderFilesLoading && cubit.allFiles.isEmpty) {
      return const CustomLoading();
    }
    if (state is EvidenceFolderFilesFailure && cubit.allFiles.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(40.w),
          child: RetryWidget(
            title: state.error,
            onPressed: () => cubit.getStatistics(
              academicYearId: widget.academicYearId,
              termId: widget.termId,
              levelId: widget.levelId,
              departmentId: widget.departmentId,
            ),
          ),
        ),
      );
    }
    final list = cubit.filteredFiles;
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.analytics_outlined,
              size: 64.sp,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 12.h),
            Text(
              'noDataFound'.tr(),
              style: GoogleFonts.almarai(fontSize: 13.sp, color: Colors.grey),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
      itemCount: list.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        return EvidenceFolderFileItem(
          file: list[index],
          isArabic: context.locale.languageCode == 'ar',
          folderId: -1,
        );
      },
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: const Color(0xFF0F569E),
          borderRadius: BorderRadius.circular(12.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade600,
        labelStyle: GoogleFonts.almarai(
          fontWeight: FontWeight.bold,
          fontSize: 15.sp,
        ),
        tabs: [
          Tab(text: "files".tr()),
          Tab(text: "analysis".tr()),
        ],
      ),
    );
  }

  Widget _buildStatisticsAnalysisTab() {
    return BlocBuilder<GetFileDataCubit, GetFileDataState>(
      builder: (context, state) {
        if (state is GetFileDataLoading) {
          return const Center(child: CustomLoading());
        }

        if (state is GetFileDataFailure) {
          return SizedBox.expand(
            child: Align(
              alignment: Alignment.center,
              child: RetryWidget(
                title: state.errorMessage,
                onPressed: () => GetFileDataCubit.get(context).getFileData(
                  courseId: widget.courseId,
                  academicYearId: widget.academicYearId,
                  termId: widget.termId,
                  levelId: widget.levelId,
                  departmentId: widget.departmentId,
                ),
              ),
            ),
          );
        }
        if (state is GetFileDataSuccess) {
          if (state.data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.analytics_outlined,
                    size: 64.sp,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "noDataAvailable".tr(),
                    style: GoogleFonts.almarai(
                      fontSize: 13.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  TextButton.icon(
                    onPressed: () => _refreshFileData(),
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text("refresh".tr()),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF0F569E),
                      textStyle: GoogleFonts.almarai(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          }
          return CourseStatisticsDashboard(data: state.data.first);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
