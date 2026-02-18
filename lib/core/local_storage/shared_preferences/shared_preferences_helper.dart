import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final SharedPreferences pref;
  static const String userToken = "user_token";
  static const String firstInstall = "first_install";
  static const String prefUser = "user_data";
  static const _themeKey = 'theme_mode';

  SharedPreferencesHelper({required this.pref});

  Future<void> saveThemeMode(ThemeMode mode) async {
    await pref.setString(_themeKey, mode.name);
  }

  ThemeMode getThemeMode() {
    final value = pref.getString(_themeKey);

    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  Future<bool> clear() async {
    try {
      return await pref.clear();
    } catch (e) {
      // Handle error (e.g., log it)
      print("Error clearing SharedPreferences: $e");
      return false; // Or rethrow the error
    }
  }

  bool isLoggedIn() {
    return getToken() != null &&
        getToken()!.isNotEmpty; // Null check and then emptiness check
  }

  String? getToken() {
    // Returns null if token doesn't exist
    return pref.getString(userToken);
  }

  Future<void> saveUserToken(String token) async {
    try {
      await pref.setString(userToken, token);
    } catch (e) {
      print('Error saving token: $e');
      // Handle error or rethrow
    }
  }

  Future<void> saveUserData(String userDataInJson) async {
    // Use a Map
    try {
      await pref.setString(prefUser, userDataInJson);
    } catch (e) {
      print("Error saving user data: $e");
      // Handle or rethrow
    }
  }

  String? getUserName() {
    // Returns null if user data or name is not found
    try {
      final userDataString = pref.getString(prefUser);
      if (userDataString != null && userDataString.isNotEmpty) {
        final userData = json.decode(userDataString) as Map<String, dynamic>;
        return userData['name'] as String?; // Correct type casting
      }
      return null;
    } catch (e) {
      print("Error getting user name: $e");
      return null;
    }
  }

  Future<void> removeUserData() async {
    try {
      await pref.remove(userToken);
      await pref.remove(prefUser);
    } catch (e) {
      print("Error removing user data: $e");
      // Handle or rethrow
    }
  }
}
