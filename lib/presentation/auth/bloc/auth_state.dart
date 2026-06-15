part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadInProgress extends AuthState {}

final class AuthCodeSent extends AuthState {
  final String phoneNumber;
  final String verificationId;
  final int? resendToken;

  AuthCodeSent({
    required this.phoneNumber,
    required this.verificationId,
    required this.resendToken,
  });
}

final class AuthProfileFilled extends AuthState {
  final String phoneNumber;

  AuthProfileFilled({required this.phoneNumber});
}

final class AuthLoadFailure extends AuthState {
  final String error;

  AuthLoadFailure({required this.error});
}

final class AuthCodeVerified extends AuthState {
  final String phoneNumber;

  AuthCodeVerified({required this.phoneNumber});
}

final class AuthProfileSubmitted extends AuthState {
  final String phoneNumber;

  AuthProfileSubmitted({required this.phoneNumber});
}

