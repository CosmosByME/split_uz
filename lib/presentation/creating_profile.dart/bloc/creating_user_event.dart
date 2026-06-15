part of 'creating_user_bloc.dart';

@immutable
sealed class CreatingUserEvent {}

final class CreatingUserRequested extends CreatingUserEvent {
  final String uid;
  final String phone;
  final String name;

  CreatingUserRequested({
    required this.uid,
    required this.phone,
    required this.name,
  });
}

