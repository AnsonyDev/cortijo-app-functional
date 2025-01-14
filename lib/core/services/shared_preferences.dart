import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/booking.dart';
import '../models/user_data.dart';

class LocalDataRepository {
  static final LocalDataRepository _instance = LocalDataRepository._();
  factory LocalDataRepository() {
    return _instance;
  }
  LocalDataRepository._();

  late SharedPreferences _localStorage;

  initPrefs() async {
    _localStorage = await SharedPreferences.getInstance();
  }

  int? get userId {
    return _localStorage.getInt('@userId');
  }

  set userId(int? id) {
    _localStorage.setInt('@userId', id!);
  }

  String? get authToken {
    return _localStorage.getString('@auth_token');
  }

  set authToken(String? token) {
    _localStorage.setString('@auth_token', token!);
  }

  Future<void> deleteAuthToken() async {
    await _localStorage.remove('@auth_token');
  }

  set loginDataEmail(String? email) {
    _localStorage.setString('@login_email', email!);
  }

  Future<void> deleteLoginDataEmail() async {
    await _localStorage.remove('@login_email');
  }

  String? get loginDataEmail {
    return _localStorage.getString('@login_email');
  }

  set loginDataPassword(String? password) {
    _localStorage.setString('@login_password', password!);
  }

  Future<void> deleteLoginDataPassword() async {
    await _localStorage.remove('@login_password');
  }

  String? get loginDataPassword {
    return _localStorage.getString('@login_password');
  }

  UserData? get user {
    final data = _localStorage.getString('@auth_user');
    if (data != null) {
      return UserData.fromJson(jsonDecode(data));
    }
    return null;
  }

  set user(UserData? userData) {
    _localStorage.setString('@auth_user', jsonEncode(userData!.toJson()));
  }

  //Reserva

  Booking? get booking {
    final data = _localStorage.getString('@booking');
    if (data != null) {
      return Booking.fromJson(jsonDecode(data));
    }
    return null;
  }

  set booking(Booking? booking) {
    _localStorage.setString('@booking', jsonEncode(booking!.toJson()));
  }

  void deleteBooking() {
    _localStorage.remove('@booking');
  }

  Future<void> deleteUser() async {
    await _localStorage.remove('@auth_user');
  }

  bool get isLogged => _localStorage.getBool('@isLogged') ?? false;

  set isLogged(bool value) {
    _localStorage.setBool('@isLogged', value);
  }

  Future<void> logOut() async {
    _localStorage
      ..setBool('@isLogged', false)
      ..remove('@auth_user')
      ..remove('@booking')
      ..remove('@auth_token');
  }
}
