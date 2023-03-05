import 'package:flutter/foundation.dart';
import 'package:new_basics/services/auth/auth_user.dart';
import "package:equatable/equatable.dart";

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;

  const AuthState({
    required this.isLoading,
    this.loadingText = 'Please waite a moment',
  });
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;

  AuthStateLoggedIn({required this.user, required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateNeedsVerfication extends AuthState {
  const AuthStateNeedsVerfication({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateloggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateloggedOut({
    required this.exception,
    required bool isLoading,
    String? loadingText,
  }) : super(isLoading: isLoading, loadingText: loadingText);

  @override
  List<Object?> get props => [exception, isLoading];
}

class AuthStateRegistering extends AuthState {
  final Exception exception;

  AuthStateRegistering({required this.exception, required bool isLoading})
      : super(isLoading: isLoading);
}
