import '../../../../../routing/all_routes_imports.dart';

abstract class DocumentsState {}

class DocumentsInitial extends DocumentsState {}

class DocumentsLoaded extends DocumentsState {
  DocumentsLoaded(this.docs);

  final List<Doc> docs;
}
