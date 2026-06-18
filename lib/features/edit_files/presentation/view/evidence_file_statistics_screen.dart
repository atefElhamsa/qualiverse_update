import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

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
          if (state is DeleteEvidenceFileFailure) {
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
                    BuildHeaderFilesStatistics(count: cubit.allFiles.length),
                    BuildTabBarFilesStatistics(tabController: _tabController),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: BuildBodyFileStatistics(
                                  cubit: cubit,
                                  academicYearId: widget.academicYearId,
                                  termId: widget.termId,
                                  levelId: widget.levelId,
                                  departmentId: widget.departmentId,
                                ),
                              ),
                            ],
                          ),
                          BuildStatisticsAnalysisTab(
                            courseId: widget.courseId,
                            academicYearId: widget.academicYearId,
                            termId: widget.termId,
                            levelId: widget.levelId,
                            departmentId: widget.departmentId,
                            refreshFileData: _refreshFileData,
                          ),
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
}
