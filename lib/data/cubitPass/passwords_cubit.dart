import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'passwords_state.dart';

class PasswordsCubit extends Cubit<PasswordsState> {
  PasswordsCubit() : super(PasswordsInitial());
  final List<Map<String, dynamic>> values = [];
  getPass() async {
    emit(isLoading());
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? cachededData = sharedPreferences.getString("saved_passwords");
      if (cachededData != null) {
        List<dynamic> decodedList = jsonDecode(cachededData);
        values.clear();
        for (var item in decodedList) {
          values.add(Map<String, dynamic>.from(item));
        }
      }
      emit(isLoaded(List.from(values)));
    } catch (e) {
      print("Error fetching: $e");
    }
  }

  AddPassword(String name, String email, String password) async {
    emit(isLoading());

    try {
      Map<String, dynamic> newEntry = {
        "name": name,
        "email": email,
        "password": password,
      };
      values.add(newEntry);

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String jsonString = jsonEncode(values);

      await sharedPreferences.setString("saved_passwords", jsonString);

      emit(isLoaded(List.from(values)));
    } catch (e) {
      print("Error $e");
    }
  }

  updatePassword(int index, String name, String email, String password) async {
    emit(isLoading());

    try {
      values[index] = {"name": name, "email": email, "password": password};

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String jsonString = jsonEncode(values);

      await sharedPreferences.setString("saved_passwords", jsonString);

      emit(isLoaded(List.from(values)));
    } catch (e) {
      print("Error $e");
    }
  }

  deletePassword(int index) async {
    emit(isLoading());

    try {
      values.removeAt(index);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String jsonString = jsonEncode(values);

      await sharedPreferences.setString("saved_passwords", jsonString);

      emit(isLoaded(List.from(values)));
    } catch (e) {
      print("Error $e");
    }
  }
}
