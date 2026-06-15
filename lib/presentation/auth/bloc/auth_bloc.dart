import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:split_uz/data/model/user.dart';
import 'package:split_uz/domain/repository/user_repository_impl.dart';
import 'package:split_uz/domain/services/auth_service.dart';
import 'package:split_uz/domain/services/navigation_service.dart';
import 'package:split_uz/main.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SendCodeRequested>((event, emit) async {
      await _onSendCodeRequested(event, emit);
    });
    on<CodeResent>((event, emit) async {
      await _onCodeResent(event, emit);
    });
    on<CodeVerified>((event, emit) async {
      await _onCodeVerified(event, emit);
    });
    on<ProfileFilled>(_onProfileFilled);
    on<ProfileSubmitted>(_onProfileSubmitted);
  }

  Future<void> _onSendCodeRequested(
    SendCodeRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadInProgress());
    try {
      await AuthService.signInWithPhoneNumber(
        event.phoneNumber,
        onCodeSent: (verificationId, resendToken) {
          emit(
            AuthCodeSent(
              phoneNumber: event.phoneNumber,
              verificationId: verificationId,
              resendToken: resendToken,
            ),
          );
        },
        onError: (error) {
          emit(AuthLoadFailure(error: error));
        },
      );
      getIt<NavigationService>().push("/otp");
    } catch (e) {
      emit(AuthLoadFailure(error: e.toString()));
    }
  }

  Future<void> _onCodeResent(CodeResent event, Emitter<AuthState> emit) async {
    emit(AuthLoadInProgress());
    try {
      await AuthService.resendCode(
        event.phoneNumber,
        resendToken: event.resendToken,
        onCodeSent: (verificationId, resendToken) {
          emit(
            AuthCodeSent(
              phoneNumber: event.phoneNumber,
              verificationId: verificationId,
              resendToken: resendToken,
            ),
          );
        },
        onError: (error) {
          emit(AuthLoadFailure(error: error));
        },
      );
    } catch (e) {
      emit(AuthLoadFailure(error: e.toString()));
    }
  }

  Future<void> _onCodeVerified(
    CodeVerified event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadInProgress());
    try {
      final result = await AuthService.verifySmsCode(
        event.smsCode,
        event.verificationId,
      );
      final user = await UserRepositoryImpl().getUser(result.user!.uid);
      if (user == null) {
        getIt<NavigationService>().push(
          "/creatingUser",
          extra: UserModel(
            uid: result.user!.uid,
            phone: event.phoneNumber,
            displayName: "",
            createdAt: DateTime.now(),
            lastActiveAt: DateTime.now(),
            friendUids: [],
            guestRefs: [],
          ),
        );
      } else {
        getIt<NavigationService>().go("/home", extra: user);
      }
      emit(AuthCodeVerified(phoneNumber: event.phoneNumber));
    } catch (e) {
      emit(AuthLoadFailure(error: e.toString()));
      emit(
        AuthCodeSent(
          phoneNumber: event.phoneNumber,
          verificationId: event.verificationId,
          resendToken: event.resendToken,
        ),
      );
    }
  }

  void _onProfileFilled(ProfileFilled event, Emitter<AuthState> emit) {
    emit(AuthProfileFilled(phoneNumber: event.phoneNumber));
  }

  void _onProfileSubmitted(ProfileSubmitted event, Emitter<AuthState> emit) {
    emit(AuthProfileSubmitted(phoneNumber: event.phoneNumber));
  }
}
