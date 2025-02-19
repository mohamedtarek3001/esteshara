part of 'ai_cubit.dart';

@immutable
abstract class AiState {}

final class AiInitial extends AiState {}

class AiLoading extends AiState {}

class AiSuccess extends AiState {
  final String response;
  AiSuccess(this.response);
}

class AiFailure extends AiState {
  final String error;
  AiFailure(this.error);
}
