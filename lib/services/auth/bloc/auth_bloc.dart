import 'package:bloc/bloc.dart';
import 'package:new_basics/services/auth/auth_provider.dart';
import 'package:new_basics/services/auth/bloc/auth_event.dart';
import 'package:new_basics/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthStateUninitialized(isLoading: true)) {
    on<AuthEventSendEmailVerfication>((event, emit) async {
      await provider.sendEmailVerfication();
      emit(state);
    });

    on<AuthEventShouldRegister>((event, emit) {
      emit(const AuthStateRegistering(
        exception: null,
        isLoading: false,
      ));
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
        emit(const AuthStateNeedsVerfication(
          isLoading: false,
        ));
      } on Exception catch (e) {
        emit(AuthStateRegistering(
          exception: e,
          isLoading: false,
        ));
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
        emit(const AuthStateNeedsVerfication(isLoading: false));
      } else {
        emit(AuthStateLoggedIn(
          user: user,
          isLoading: false,
        ));
      }
    }));
    // login
    on<AuthEventLogIn>(((event, emit) async {
      emit(
        const AuthStateloggedOut(
          exception: null,
          isLoading: false,
          loadingText: 'Please wait a momentino',
        ),
      );

      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );
        emit(
          const AuthStateloggedOut(
            exception: null,
            isLoading: false,
          ),
        );
        if (!user.isEmailVerified) {
          emit(
            const AuthStateloggedOut(
              exception: null,
              isLoading: false,
            ),
          );
          emit(const AuthStateNeedsVerfication(isLoading: false));
        } else {
          emit(
            const AuthStateloggedOut(
              exception: null,
              isLoading: false,
            ),
          );
          emit(AuthStateLoggedIn(
            user: user,
            isLoading: false,
          ));
        }
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

    on<AuthEventForgetPassword>(
      (event, emit) async {
        emit(const AuthStateForgetPassword(
          exception: null,
          hasSentEmail: false,
          isLoading: false,
        ));
        final email = event.email;
        if (email == null) {
          return;
        }
        emit(const AuthStateForgetPassword(
          exception: null,
          hasSentEmail: false,
          isLoading: true,
        ));
        bool didSendEmail;
        Exception? exception;
        try {
          await provider.sendPasswordReset(toEmail: email);
          didSendEmail = true;
          exception = null;
        } on Exception catch (e) {
          didSendEmail = false;
          exception = e;
        }
        emit(AuthStateForgetPassword(
          exception: exception,
          hasSentEmail: didSendEmail,
          isLoading: false,
        ));
      },
    );
  }
}
