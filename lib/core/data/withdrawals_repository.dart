import 'dart:developer';

import 'package:cortijo_app/core/models/withdrawals.dart';

import '_api_classes.dart';
import '_base_api_url.dart';

class WithdrawalsRepository {
  WithdrawalsRepository(this.apiClient);

  final MyApiClient apiClient;

  Future<List<Withdrawal>> getWithdrawals() async {
    final dynamic res =
        await apiClient.getRequest('$BASE_API_URL/api/withdrawals');
    log(res.toString());
    return (res['withdrawals'] as List).map(Withdrawal.fromJson).toList();
  }
}
