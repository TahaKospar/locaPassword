part of 'passwords_cubit.dart';

@immutable
sealed class PasswordsState {}

final class PasswordsInitial extends PasswordsState {}

final class isLoading extends PasswordsState {}

final class isLoaded extends PasswordsState {
  final List<Map<String, dynamic>> posts;
  isLoaded(this.posts);
}

final class setPassword extends PasswordsState {}

final class AddPassword extends PasswordsState {}
final class updatePassword extends PasswordsState {}
final class deletePassword extends PasswordsState {}
