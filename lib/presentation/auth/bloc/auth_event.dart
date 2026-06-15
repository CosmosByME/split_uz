part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SendCodeRequested extends AuthEvent {
  final String phoneNumber;

  SendCodeRequested({required this.phoneNumber});
}

class CodeResent extends AuthEvent {
  final String phoneNumber;
  final int? resendToken;

  CodeResent({required this.phoneNumber, required this.resendToken});
}

class CodeVerified extends AuthEvent {
  final String smsCode;
  final String verificationId;
  final String phoneNumber;
  final int? resendToken;

  CodeVerified({
    required this.smsCode,
    required this.verificationId,
    required this.phoneNumber,
    this.resendToken
  });
}

class ProfileFilled extends AuthEvent {
  final String phoneNumber;
  final String name;

  ProfileFilled({required this.phoneNumber, required this.name});
}

class ProfileSubmitted extends AuthEvent {
  final String phoneNumber;
  final String name;

  ProfileSubmitted({required this.phoneNumber, required this.name});
}
