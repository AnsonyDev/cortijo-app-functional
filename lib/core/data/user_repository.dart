import 'package:cortijo_app/core/models/fags.dart';
import 'package:cortijo_app/core/models/legal.dart';
import 'package:cortijo_app/core/models/user_details_response.dart';
import 'package:cortijo_app/core/models/wifi.dart';

import '_api_classes.dart';
import '_base_api_url.dart';

class UserRepository {
  UserRepository(this.apiClient);

  final MyApiClient apiClient;

  Future<UserDetailsRespose> getDetails() async {
    final dynamic res =
        await apiClient.getRequest('$BASE_API_URL/api/user/details');
    return UserDetailsRespose.fromJson(res);
  }

  Future<Wifi> getWifi() async {
    final dynamic res =
        await apiClient.getRequest('$BASE_API_URL/api/pages/wifi');
    return Wifi.fromJson(res["wifis"][0]);
  }

  Future<List<Legal>> getLegal() async {
    final dynamic res =
        await apiClient.getRequest('$BASE_API_URL/api/pages/legal');
    return (res["pages"] as List).map(Legal.fromJson).toList();
  }

  Future<List<Faqs>> getFaqs() async {
    final dynamic res =
        await apiClient.getRequest('$BASE_API_URL/api/pages/faqs');
    return (res["faqs"] as List).map(Faqs.fromJson).toList();
  }
}
