import 'package:qualiverse/features/dashboard/data/models/dashboard_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'documents_state.dart';

class DocumentsCubit extends Cubit<DocumentsState> {
  DocumentsCubit() : super(DocumentsInitial());

  static DocumentsCubit get(context) => BlocProvider.of(context);

  void loadDashboardDocuments(DashboardData data) {
    // Note: If DashboardData doesn't contain a specific list of documents, 
    // we can either show an empty list or show relevant data.
    // For now, let's clear the static data and prepare for real indicators if they exist.
    
    // If you have specific files in data.indicatorOverview?.indicatorsPerCriterion, 
    // you can map them here.
    
    emit(DocumentsLoaded([])); // Showing empty for now since API returns [] for indicators
  }

  void loadDocuments() {
    emit(DocumentsLoaded([]));
  }
}
