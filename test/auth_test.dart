import 'package:flutter/material.dart';
import 'package:new_basics/services/auth/auth_exceptions.dart';
import 'package:new_basics/services/auth/auth_provider.dart';
import 'package:new_basics/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group("Mock authentication", () {
    final provider = MockAuthProvider();
    test("should not be initialized", () {
      expect(provider.isInitialized, false);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInialized = false;
  bool get isInitialized => _isInialized;
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(Duration(seconds: 1));
    _isInialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    if (email == "foo@bar.com") throw UserNotFoundException();
    if (password == 'foobar') throw WrongPasswordException();
    final user = AuthUser(isEmailVerified: false, email: '', id: 'my_id');
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UseerNotLoggedInAuthException();
    await Future.delayed(Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerfication() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundException();
    final newUser = AuthUser(isEmailVerified: true, email: '', id: 'my_id');
    _user = newUser;
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) {
    throw UnimplementedError();
  }
}
