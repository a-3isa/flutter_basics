import 'package:flutter/foundation.dart';
import 'package:new_basics/services/auth/auth_user.dart';
import "package:equatable/equatable.dart";

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;

  AuthStateLoggedIn(this.user);
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized();
}

class AuthStateNeedsVerfication extends AuthState {
  const AuthStateNeedsVerfication();
}

class AuthStateloggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  final bool isLoading;
  const AuthStateloggedOut({
    required this.exception,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [exception, isLoading];
}

class AuthStateRegistering extends AuthState {
  final Exception exception;

  AuthStateRegistering(this.exception);
}
