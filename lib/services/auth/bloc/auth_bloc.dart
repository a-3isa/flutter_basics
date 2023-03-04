import 'package:bloc/bloc.dart';
import 'package:new_basics/services/auth/auth_provider.dart';
import 'package:new_basics/services/auth/bloc/auth_event.dart';
import 'package:new_basics/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized()) {
    on<AuthEventSendEmailVerfication>((event, emit) async {
      await provider.sendEmailVerfication();
      emit(state);
    });

    on<AuthEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        await provider.createUser(
          email: email,
          password: password,
        );
        await provider.sendEmailVerfication();
        emit(const AuthStateNeedsVerfication());
      } on Exception catch (e) {
        emit(AuthStateRegistering(e));
      }
    });
    // initialize
    on<AuthEventInitialize>(((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(
          const AuthStateloggedOut(
            exception: null,
            isLoading: false,
          ),
        );
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerfication());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    }));
    // login
    on<AuthEventLogIn>(((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );
        if (!user.isEmailVerified) {
          emit(
            const AuthStateloggedOut(
              exception: null,
              isLoading: false,
            ),
          );
          emit(const AuthStateNeedsVerfication());
        } else {
          emit(
            const AuthStateloggedOut(
              exception: null,
              isLoading: false,
            ),
          );
        }

        emit(AuthStateLoggedIn(user));
      } on Exception catch (e) {
        emit(
          AuthStateloggedOut(
            exception: e,
            isLoading: false,
          ),
        );
      }
    }));
    // logout
    on<AuthEventLogOut>(((event, emit) async {
      try {
        await provider.logOut();
        emit(
          const AuthStateloggedOut(
            exception: null,
            isLoading: false,
          ),
        );
      } on Exception catch (e) {
        emit(
          AuthStateloggedOut(
            exception: e,
            isLoading: false,
          ),
        );
      }
    }));
  }
}
