part of 'ai_description_cubit.dart';

abstract class AiDescriptionState {}

class AiDescriptionInitial extends AiDescriptionState {}

class AiDescriptionPageChanged extends AiDescriptionState {
  final int currentPage;
  AiDescriptionPageChanged(this.currentPage);
}

class AiDescriptionLoading extends AiDescriptionState {}

class AiDescriptionSuccess extends AiDescriptionState {}

class AiDescriptionError extends AiDescriptionState {
  final String message;
  AiDescriptionError(this.message);
}
