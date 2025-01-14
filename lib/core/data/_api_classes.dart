abstract class MyApiClient {
  dynamic getRequest(
    String url, {
    Map<String, dynamic>? params,
    Map<String, String>? customHeaders,
  });
  dynamic postRequest(
    String url, {
    Object? body,
    Map<String, String>? customHeaders,
  });
  dynamic putRequest(
    String url, {
    Map<String, dynamic>? params,
    Object? body,
    Map<String, String>? customHeaders,
  });
  dynamic deleteRequest(
    String url, {
    Map<String, dynamic>? params,
    Object? body,
    Map<String, String>? customHeaders,
  });
}
