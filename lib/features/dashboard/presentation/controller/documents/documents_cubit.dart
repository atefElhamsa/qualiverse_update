import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class DocumentsCubit extends Cubit<DocumentsState> {
  DocumentsCubit() : super(DocumentsInitial());

  static DocumentsCubit get(context) => BlocProvider.of(context);

  final List<Doc> sampleDocs = [
    const Doc(
      indicatorName: 'Assessment method',
      criterionName: 'Continues improvement',
      fileName: 'Assessment method_2022_128.PDF',
      status: 'Rejected',
      uploadedBy: 'DR / Omnia',
      year: 2022,
      quarter: 'QTR 1',
      month: 'March',
      day: 12,
    ),
    const Doc(
      indicatorName: 'Assessment method',
      criterionName: 'Continues improvement',
      fileName: 'Assessment method_2022_128.PDF',
      status: 'Pending',
      uploadedBy: 'DR / Omnia',
      year: 2022,
      quarter: 'QTR 1',
      month: 'March',
      day: 12,
    ),
    const Doc(
      indicatorName: 'Assessment method',
      criterionName: 'Continues improvement',
      fileName: 'Assessment method_2022_128.PDF',
      status: 'Approved',
      uploadedBy: 'DR / Omnia',
      year: 2022,
      quarter: 'QTR 1',
      month: 'March',
      day: 12,
    ),
    const Doc(
      indicatorName: 'Assessment method',
      criterionName: 'Continues improvement',
      fileName: 'Assessment method_2022_128.PDF',
      status: 'Reviewed',
      uploadedBy: 'DR / Omnia',
      year: 2022,
      quarter: 'QTR 1',
      month: 'March',
      day: 12,
    ),
    const Doc(
      indicatorName: 'Assessment method',
      criterionName: 'Continues improvement',
      fileName: 'Assessment method_2022_128.PDF',
      status: 'Rejected',
      uploadedBy: 'DR / Omnia',
      year: 2022,
      quarter: 'QTR 1',
      month: 'March',
      day: 12,
    ),
    const Doc(
      indicatorName: 'Assessment method',
      criterionName: 'Continues improvement',
      fileName: 'Assessment method_2022_128.PDF',
      status: 'Rejected',
      uploadedBy: 'DR / Omnia',
      year: 2022,
      quarter: 'QTR 1',
      month: 'March',
      day: 12,
    ),
    const Doc(
      indicatorName: 'Assessment method',
      criterionName: 'Continues improvement',
      fileName: 'Assessment method_2022_128.PDF',
      status: 'Rejected',
      uploadedBy: 'DR / Omnia',
      year: 2022,
      quarter: 'QTR 1',
      month: 'March',
      day: 12,
    ),
    const Doc(
      indicatorName: 'Assessment method',
      criterionName: 'Continues improvement',
      fileName: 'Assessment method_2022_128.PDF',
      status: 'Rejected',
      uploadedBy: 'DR / Omnia',
      year: 2022,
      quarter: 'QTR 1',
      month: 'March',
      day: 12,
    ),
    const Doc(
      indicatorName: 'Assessment method',
      criterionName: 'Continues improvement',
      fileName: 'Assessment method_2022_128.PDF',
      status: 'Rejected',
      uploadedBy: 'DR / Omnia',
      year: 2022,
      quarter: 'QTR 1',
      month: 'March',
      day: 12,
    ),
    const Doc(
      indicatorName: 'Assessment method',
      criterionName: 'Continues improvement',
      fileName: 'Assessment method_2022_128.PDF',
      status: 'Rejected',
      uploadedBy: 'DR / Omnia',
      year: 2022,
      quarter: 'QTR 1',
      month: 'March',
      day: 12,
    ),
  ];

  void loadDocuments() {
    emit(DocumentsLoaded(sampleDocs));
  }
}
