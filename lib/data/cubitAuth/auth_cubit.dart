import 'package:bloc/bloc.dart';
import 'package:locapass/data/cubitAuth/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  void saveMasterPassword(String pin) async {
    emit(AuthLoading());
    try {
      SharedPreferences sharedPreferencesPassword =
          await SharedPreferences.getInstance();

      sharedPreferencesPassword.setString("MasterPassword", pin);
      emit(MasterKeySetSuccess());
    } catch (e) {
      emit(AuthUnlockFailure("Error $e"));
    }
  }

  void verifyPassword(String enteredPin) async {
    emit(AuthLoading());
  }
}
