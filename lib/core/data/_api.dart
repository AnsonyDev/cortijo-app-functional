import 'dart:convert';

import 'package:http/http.dart' as http;

import '../services/shared_preferences.dart';
import '_api_classes.dart';
import 'network_error.dart';

class MyApi extends MyApiClient {
  final _localRepository = LocalDataRepository();
  @override
  dynamic getRequest(
    String url, {
    Map<String, dynamic>? params,
    Map<String, String>? customHeaders,
  }) async {
    final response = await http.get(
      _parseUrl(url, params: params),
      headers: {...await _getHeaders(), ...customHeaders ?? {}},
    );

    return _handleResponse(response);
  }

  @override
  dynamic postRequest(
    String url, {
    Object? body,
    Map<String, String>? customHeaders,
  }) async {
    final response = await http.post(
      _parseUrl(url),
      headers: {...await _getHeaders(), ...customHeaders ?? {}},
      body: body,
    );
    return _handleResponse(response);
  }

  @override
  dynamic putRequest(
    String url, {
    Map<String, dynamic>? params,
    Object? body,
    Map<String, String>? customHeaders,
  }) async {
    final response = await http.put(
      _parseUrl(url, params: params),
      headers: await _getHeaders(),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  @override
  dynamic deleteRequest(
    String url, {
    Map<String, dynamic>? params,
    Object? body,
    Map<String, String>? customHeaders,
  }) async {
    final response = await http.delete(
      _parseUrl(url, params: params),
      headers: await _getHeaders(),
      body: body,
    );
    return _handleResponse(response);
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = _localRepository.authToken;
    return {
      ...allHeaders,
      ...token != null ? {'Authorization': 'Bearer $token'} : {}
    };
  }

  Uri _parseUrl(String url, {Map<String, dynamic>? params}) {
    var parsedUrl = Uri.parse(url);
    if (params != null) {
      parsedUrl = parsedUrl.replace(queryParameters: params);
    }
    return parsedUrl;
  }

  dynamic _handleResponse(http.Response response) {
    final code = response.statusCode;
    final rawJsonString = response.body == '' ? '{}' : response.body;

    if (code >= 400) {
      throw ApiException(code: code, message: response.body);
    }

    return jsonDecode(rawJsonString);
  }
}

final allHeaders = {
  'Accept': 'application/json',
};
const headerContentTypeApplicationJson = {
  'Content-Type': 'application/json',
};
