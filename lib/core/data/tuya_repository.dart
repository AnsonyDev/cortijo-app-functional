import 'package:cortijo_app/core/data/_base_api_url.dart';

import '_api.dart';
import '_api_classes.dart';

class TuyaRepository {
  final MyApiClient apiClient;

  TuyaRepository(this.apiClient);

  Future<bool> openGate() async {
    final res = await apiClient.getRequest(
      '$BASE_API_URL/api/tuya/open_door',
      customHeaders: headerContentTypeApplicationJson,
    );
    return res["result"] as bool;
  }

  Future<bool> closeGate() async {
    final res = await apiClient.getRequest(
      '$BASE_API_URL/api/tuya/close_door',
      customHeaders: headerContentTypeApplicationJson,
    );
    return res["result"] as bool;
  }

  Future<bool> deleteCount() async {
    bool res = false;
    try{
      await apiClient.deleteRequest(
        '$BASE_API_URL/api/user',
        customHeaders: allHeaders,
      );
      res = true;
    }catch(_){}
    return res;
  }
}
