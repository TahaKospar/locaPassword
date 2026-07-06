abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class MasterKeySetSuccess extends AuthState {}

class AuthUnlockSuccess extends AuthState {}

class AuthUnlockFailure extends AuthState {
  final String errorMessage;

  AuthUnlockFailure(this.errorMessage);
}
