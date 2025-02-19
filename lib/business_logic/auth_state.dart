part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

/// Initial state
final class AuthInitial extends AuthState {}

/// Loading state
class AuthLoading extends AuthState {}

/// Success state when authentication is successful
class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
}

/// Failure state with error message
class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}

/// State when a PDF is selected
class PdfPicked extends AuthState {
  final File pdfFile;
  PdfPicked(this.pdfFile);
}

/// State when user profile is loaded from Firestore
class UserProfileLoaded extends AuthState {
  final Map<String, dynamic> userData;
  UserProfileLoaded(this.userData);
}

/// State when user profile is successfully updated
class UserProfileUpdated extends AuthState {}

/// State when user profile is successfully deleted
class UserProfileDeleted extends AuthState {}