import 'package:cortijo_app/core/data/auth_repository.dart';
import 'package:cortijo_app/core/data/requests_repository.dart';
import 'package:cortijo_app/core/data/withdrawals_repository.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:get_it/get_it.dart';

import '../features/routes/router.gr.dart';
import '../core/logger.dart';
import 'data/_api.dart';
import 'data/checkin_repository.dart';
import 'data/notices_repository.dart';
import 'data/services_repository.dart';
import 'data/tuya_repository.dart';
import 'data/user_repository.dart';
import 'data/wallet_repository.dart';

GetIt locator = GetIt.instance;

class LocatorInjector {
  static final Logger _log = getLogger('LocatorInjector');

  static Future<void> setupLocator() async {
    final myApi = MyApi();
    _log.d('Initializing Services');

    locator
      ..registerSingleton<AppRouter>(AppRouter())
      ..registerSingleton<GlobalKey<ScaffoldMessengerState>>(
          GlobalKey<ScaffoldMessengerState>())
      ..registerLazySingleton(() => AuthRepository(myApi))
      ..registerLazySingleton(() => WithdrawalsRepository(myApi))
      ..registerLazySingleton(() => RequestsRepository(myApi))
      ..registerLazySingleton(() => WalletRepository(myApi))
      ..registerLazySingleton(() => CheckInRepository(myApi))
      ..registerLazySingleton(() => NoticesRepository(myApi))
      ..registerLazySingleton(() => UserRepository(myApi))
      ..registerLazySingleton(() => ServicesRepository(myApi))
      ..registerLazySingleton(() => TuyaRepository(myApi));
  }
}
