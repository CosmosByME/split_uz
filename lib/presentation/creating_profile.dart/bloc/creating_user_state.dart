part of 'creating_user_bloc.dart';

@immutable
sealed class CreatingUserState {}

final class CreatingUserInitial extends CreatingUserState {}

final class CreatingUserLoading extends CreatingUserState {}

final class CreatingUserSuccess extends CreatingUserState {
  final UserModel user;
  CreatingUserSuccess({required this.user});
}

final class CreatingUserError extends CreatingUserState {
  final String error;
  CreatingUserError({required this.error});
}
