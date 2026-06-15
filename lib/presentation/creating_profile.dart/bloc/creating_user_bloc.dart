import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:split_uz/data/model/user.dart';
import 'package:split_uz/domain/repository/user_repository_impl.dart';
import 'package:split_uz/domain/services/navigation_service.dart';
import 'package:split_uz/main.dart';

part 'creating_user_event.dart';
part 'creating_user_state.dart';

class CreatingUserBloc extends Bloc<CreatingUserEvent, CreatingUserState> {
  CreatingUserBloc() : super(CreatingUserInitial()) {
    on<CreatingUserRequested>(_onCreatingUserRequested);
  }

  Future<void> _onCreatingUserRequested(
    CreatingUserRequested event,
    Emitter<CreatingUserState> emit,
  ) async {
    emit(CreatingUserLoading());
    try {
      final user = UserModel(
        uid: event.uid,
        phone: event.phone,
        displayName: event.name,
        telegramId: null,
        avatarUrl: null,
        createdAt: DateTime.now(),
        lastActiveAt: DateTime.now(),
        friendUids: [],
        guestRefs: [],
      );
      await UserRepositoryImpl().setUser(user);
      emit(CreatingUserSuccess(user: user));
      getIt<NavigationService>().go("/home", extra: user);
    } catch (e) {
      emit(CreatingUserError(error: e.toString()));
    }
  }
}
