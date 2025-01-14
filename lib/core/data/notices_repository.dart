import 'package:cortijo_app/core/models/notices.dart';

import '_api_classes.dart';
import '_base_api_url.dart';

class NoticesRepository {
  NoticesRepository(this.apiClient);

  final MyApiClient apiClient;

  Future<List<Notices>> getNotices() async {
    final dynamic res =
        await apiClient.getRequest('$BASE_API_URL/api/notifications/get');
    return (res["notifications"] as List).map(Notices.fromJson).toList();
  }

  Future<void> deleteNotices(String id) async {
    await apiClient
        .postRequest('$BASE_API_URL/api/notifications/mark-as-read/$id');
  }
}
