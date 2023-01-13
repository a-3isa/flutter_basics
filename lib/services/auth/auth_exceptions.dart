// login
class UserNotFoundException implements Exception {}

class WrongPasswordException implements Exception {}

//register
class WeakPasswordException implements Exception {}

class EmailAlreadyInUseException implements Exception {}

class InvalidEmailException implements Exception {}

//generic
class GenericAuthException implements Exception {}

class UseerNotLoggedInAuthException implements Exception {}
