import 'dart:convert';

import 'package:cortijo_app/core/models/wallet_transactions.dart';

import '_api_classes.dart';
import '_base_api_url.dart';

class WalletRepository {
  WalletRepository(this.apiClient);

  final MyApiClient apiClient;

  Future<WalletTransactions> getTransactions() async {
    final dynamic res = await apiClient.getRequest('$BASE_API_URL/api/wallet');
    return WalletTransactions.fromJson(res["data"]);
  }

  Future<void> pagar() async {
    await apiClient
        .getRequest('$BASE_API_URL/api/tpv', params: {"redirection": "true"});
  }
}
