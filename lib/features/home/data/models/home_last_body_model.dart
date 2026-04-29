import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:easy_localization/easy_localization.dart';

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
  HomeLastBodyModel(
    image: AppImages.basicModels,
    title: 'basicModels',
    description: 'AccessToOfficialQualityProcessTemplates',
  ),
  HomeLastBodyModel(
    image: AppImages.reportDescription,
    title: "reportDescription",
    description: "FollowAccreditationAndQualityProceduresStepByStep",
  ),
  HomeLastBodyModel(
    image: AppImages.accreditation,
    title: "accreditation",
    description:
        "PresentingAcademicAndInstitutionalQualityStandardsInASimplifiedManner",
  ),
  HomeLastBodyModel(
    image: AppImages.evaluationMethods,
    title: "evaluationMethods",
    description:
        "ProvideClearIndicatorsForPerformanceEvaluationAndAccreditation",
  ),
];
