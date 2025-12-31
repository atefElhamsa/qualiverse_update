import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class HomeLastBodyModel {
  final String image;
  final String title;
  final String description;

  const HomeLastBodyModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<HomeLastBodyModel> homeLastItems = [
  const HomeLastBodyModel(
    image: AppImages.basicModels,
    title: 'BasicModels',
    description: 'AccessToOfficialQualityProcessTemplates',
  ),
  const HomeLastBodyModel(
    image: AppImages.reportDescription,
    title: "ReportDescription",
    description: "FollowAccreditationAndQualityProceduresStepByStep",
  ),
  const HomeLastBodyModel(
    image: AppImages.accreditation,
    title: "accreditation",
    description:
        "PresentingAcademicAndInstitutionalQualityStandardsInASimplifiedManner",
  ),
  const HomeLastBodyModel(
    image: AppImages.evaluationMethods,
    title: "Evaluation methods",
    description:
        "ProvideClearIndicatorsForPerformanceEvaluationAndAccreditation",
  ),
];
