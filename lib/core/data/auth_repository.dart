import 'package:cortijo_app/core/services/push_notifications.dart';

import '../models/user_data.dart';
import '../services/shared_preferences.dart';
import '_api_classes.dart';
import '_base_api_url.dart';

class AuthRepository {
  AuthRepository(this.apiClient);

  final MyApiClient apiClient;

  Future<void> login({required String email, required String password}) async {
    final body = <String, dynamic>{
      'email': email,
      'password': password,
      'device_token': tokenFirebase ?? ''
    };
    final dynamic res =
        await apiClient.postRequest('$BASE_API_URL/api/login', body: body);
    LocalDataRepository().authToken = res["access_token"];
    final user = UserData.fromJson(res['user']);
    LocalDataRepository().isLogged = true;
    LocalDataRepository().user = user;
  }

  Future<void> register({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final body = <String, dynamic>{
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'privacy_policies': '1',
    };
    final dynamic res =
        await apiClient.postRequest('$BASE_API_URL/api/register', body: body);
    LocalDataRepository().authToken = res["access_token"];
    final user = UserData.fromJson(res['user']);
    LocalDataRepository().isLogged = true;
    LocalDataRepository().user = user;
  }

  Future<String?> forgotPassword({required String email}) async {
    final body = <String, dynamic>{'email': email};
    final dynamic res = await apiClient
        .postRequest('$BASE_API_URL/api/forgot-password', body: body);
    return res['message'] as String?;
  }

  Future<String?> getPin() async {
    final dynamic res = await apiClient.getRequest('$BASE_API_URL/api/user');

    return res["data"]["pin"] as String?;
  }

  Future<String?> newPin() async {
    final dynamic res =
        await apiClient.getRequest('$BASE_API_URL/api/user/newPin');

    return res["pin"] as String?;
  }
}
